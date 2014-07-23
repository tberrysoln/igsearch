require 'httparty'
require 'street_address'
require 'json'

module Igsearch

  def self.live_api?
    HTTParty.get('http://api.infoconnect.com/v1/').code == 200
  end

  # docs: http://developer.infoconnect.com/post-search-0
  class Person
    include HTTParty

    base_uri "api.infoconnect.com/v1/people"

    def initialize(apikey=Igsearch.apikey)
      # this changes it for all instances
      self.class.default_params :apikey => apikey
    end

    def self.hi
      return "success #{Igsearch.apikey}"
    end

    def self.find(id, options={})

      response = get("/#{id}", options)

      return response.parsed_response if response.success?
      raise response.response
    end

    def self.search(criteria, options={})
      response = post('/search', {body: criteria})

      return response.parsed_response if response.success?
      raise response.response
    end

    def self.search_raw_address(raw_address, options={})
      p_address = StreetAddress::US.parse(ra)
      
      address = self.render_parsed_address_to_api_format(p_address)

      self.search({:AddressParsed => address}, options)
    end

    def self.count(criteria, options={})
      response = post('/count', {body: criteria})

      return response.parsed_response["MatchCount"] if response.success?
      raise response.response
    end

    private
    def render_parsed_address_to_api_format(address)
      ap = {} # address, parsed and rendered for infogroup API
      ap["Number"] = address.number
      ap["PreDirectional"] = address.prefix
      ap["Name"] = address.street
      ap["Suffix"] = address.street_type # this is not a mistake
      ap["PostDirectional"] = address.suffix # this is not a mistake
      # clean up null keys/values
      ap.delete_if { |k, v| v.nil? }
      return ap
    end
  end
end