require 'httparty'
require 'json'

module Igsearch

  def self.live_api?
    HTTParty.get('http://api.infoconnect.com/v1/').code == 200
  end

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

    def self.count(criteria, options={})
      response = post('/count', {body: criteria})

      return response.parsed_response["MatchCount"] if response.success?
      raise response.response
    end

  end
end