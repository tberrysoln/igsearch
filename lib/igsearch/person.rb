require 'httparty'
require 'street_address'
require 'json'

module Igsearch

  def self.live_api?
    HTTParty.get('https://api.infoconnect.com/v1/', :verify => false).code == 404
  end

  # docs: http://developer.infoconnect.com/post-search-0
  class Person
    include HTTParty

    base_uri "https://api.infoconnect.com/v1/people"
    headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'
    format :json
    # debug_output $stdout

    # BUG/PROBLEM:
    # still need to .to_json to send json...

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
      handle_error response
    end

    def self.search(criteria, options={})
      response = post('/search', :body => criteria.to_json, :verify => false)

      return response.parsed_response if response.success?
      handle_error response
    end

    def self.search_raw_address(raw_address, options={})
      p_address = StreetAddress::US.parse(raw_address)

      return [] if p_address.nil?

      address = self.render_parsed_address_to_api_format(p_address)
      self.search(address, options)
    end

    def self.count(criteria, options={})
      response = post('/count', body: criteria.to_json)

      return response.parsed_response["MatchCount"] if response.success?
      handle_error response
    end

    private
    def self.handle_error(response)
      raise response.response.code + ' ' + response.response.message # fix this to show resp. code and message
    end

    def self.render_parsed_address_to_api_format(address)
      ap = {} # address, parsed and rendered for infogroup API
      ap["Number"] = address.number
      ap["PreDirectional"] = address.prefix
      ap["Name"] = address.street
      # the infoconnect api has different names than
      # those used by the street_address gem
      ap["Suffix"] = address.street_type # this is not a mistake
      ap["PostDirectional"] = address.suffix # this is not a mistake
      # for buildings
      ap["UnitNumber"] = address.unit
      ap["UnitType"] = address.unit_prefix
      # clean up null keys/values
      ap.delete_if { |k, v| v.nil? }
      qap = {}
      qap["AddressParsed"] = ap
      qap["City"] = address.city
      qap["StateProvince"] = address.state
      # postal code within an array, as per spec.
      qap["PostalCode"] = [address.postal_code] unless address.postal_code.nil?

      qap.delete_if { |k, v| v.nil? }
      
      return qap
    end
  end
end
