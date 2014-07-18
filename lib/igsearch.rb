require 'igsearch/version'
require 'igsearch/person'

module Igsearch
  # Public: Set global options. 
  #
  # Yields the Igsearch module so you can set options on it.
  #
  # Returns self.
  def self.configure
    yield self
    # TODO: find a better way to do this
    self::Person.default_params :apikey => self.apikey
    self
  end
  # Public: Reset the configuration to the defaults. Useful for testing.
  #
  # Returns nil.
  def self.reset!
    @apikey = nil
  end
  class << self
    # Public: Your Infogroup API key.
    attr_accessor :apikey
  end
end

####################################
##
##   Punting to next major version:
##
########
# class Company
# end
# class SIC
# end
# class Match
# end
