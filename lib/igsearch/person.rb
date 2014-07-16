require 'httparty'
require 'json'

module Igsearch

  # def self.live_api?
  #   return false
  # end

  class Person
    include HTTParty

    base_uri "api.infoconnect.com/v1/people"
    # default_params :apikey => Igsearch.apikey

    def initialize(apikey)
      # this changes it for all instances
      self.class.default_params :apikey => apikey
    end

    def self.hi
      return "success #{Igsearch.apikey}"
    end

    def self.fetch(id, options={})

      response = self.class.get("/#{id}", options)
      return response if response.success?
      raise response.response
    end
    def search
    end
    def count
    end
  end
end