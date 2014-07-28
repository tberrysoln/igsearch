# Igsearch

This is a Ruby gem that makes it easier to talk to the [Infogroup API](http://developer.infoconnect.com/).

The Infogroup API lets you search for people or businesess based on criteria that would be useful for conducting sales activity.


## Installation

Add this line to your application's Gemfile:

    gem 'igsearch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install igsearch

## Usage

1.  Configure an API Key

Igsearch.configure do |config|
  config.apikey = ENV["INFOCONNECT_API_KEY"]
end

2.  Use the API

person = Igsearch::Person.search({
  :FirstName => "William",
  :LastName => "Gates",
  :City => "Redmond",
  :StateProvince => "WA"
}).first # .search returns an array
# => {"ETag"=>"bd62003e", "Id"=>"601223668643", "Links"=>[{"Href"=>"/v1/people/601223668643", "Rel"=>"self"}], "Address"=>"1 Microsoft Way Bldg 3", "AddressParsed"=>{"Name"=>"Microsoft", "Number"=>"1", "Suffix"=>"Way", "UnitNumber"=>"3", "UnitType"=>"Bldg"}, "City"=>"Redmond", "FirstName"=>"William", "LastName"=>"Gates", "Location"=>{"Latitude"=>47.639661, "Longitude"=>-122.130606}, "MiddleInitial"=>"H", "PostalCode"=>"98052", "StateProvince"=>"WA"} 

3. There is no step 3

## Contributing

1. Fork it ( https://github.com/hayksaakian/igsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
