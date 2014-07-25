require_relative '../../test_helper'

describe Igsearch do

  before do
    Igsearch.configure do |config|
      config.apikey = ENV["INFOCONNECT_API_KEY"]
    end
  end

  it "must say hi" do
    assert Igsearch::Person.hi.is_a?(String), "something weird is messed up"
  end

  it "must access a live API" do
    assert Igsearch.live_api?, "API is not live!"
  end

  it "must find person by id" do 
    person = Igsearch::Person.find('601223668643')
    assert person['FirstName'] == "William", "Did not find Bill Gates!"
  end

  it "must find bill gates by search" do
    people = Igsearch::Person.search({
      :FirstName => "William",
      :LastName => "Gates",
      :City => "Redmond",
      :StateProvince => "WA"
      })
    person = people.first
    assert person['Id'] == '601223668643', "This is not Bill Gates!"
  end

  it "must find bill gates by raw address" do
    people = Igsearch::Person.search_raw_address("1 Microsoft Way, Redmond, WA")

    person = people.first

    assert person['Id'] == '601223668643', "This is not Bill Gates!"
  end

  it "must count rich people named paul allen" do
    num_people = Igsearch::Person.count({
      :FirstName => "Paul",
      :LastName => "Allen",
      :ActualIncome => ["400000", "500000"]
      })
    assert num_people > 0, "Bill Gates either isnt very rich or couldnt be found"
  end
end
