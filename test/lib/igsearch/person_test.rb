require_relative '../../test_helper'
 
describe Igsearch do
 
  it "must say hi" do
    assert Igsearch::Person.hi == "Hello", "something weird is messed up"
  end

  it "must fail" do 
    assert false, "this should fail"
  end
 
end