require_relative '../../test_helper'
 
describe Igsearch do

  before do
    Igsearch.configure do |config|
      
    end
  end

  it "must say hi" do
    assert Igsearch::Person.hi == "Hello", "something weird is messed up"
  end

  it "must fail" do 
    assert false, "this should fail"
  end

  it "must access a live API" do
    assert Igsearch.live_api?, "API is not live"
  end
 
end