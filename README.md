# Lightning::Source

Ruby interface to the Lightning Source on-demand publishers' web site

## Installation

Add this line to your application's Gemfile:

    gem 'lightning-source'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lightning-source

## Usage

At present, all the module does is log in and grab sales figures for
a given time period:

    first = Date.today.ago(1.month).beginning_of_month.to_date
    last = first.end_of_month

    l = LightningSource.new(username, password)
    us_comp = l.compensation(first: first, last: last, market: "US")
    uk_comp = l.compensation(first: first, last: last, market: "UK")

This returns an array of hashes like so:

    [{:ISBN=>"9781234567890",
      :Title=>"A Book about Fish",
      :Author=>"Author, Joe",
      :ListPrice=>12.99,
      :Disc=>0.2,
      :WholesalePrice=>10.39,
      :QtySold=>2.0,
      :QtyReturn=>0.0,
      :NetQty=>2.0,
      :Sales=>20.78,
      :Returns=>0.0,
      :NetSales=>20.78,
      :PrintCharge=>-5.34,
      :SetupRecovery=>0.0,
      :Adjust=>0.0,
      :ReturnCharge=>0.0,
      :NetPubComp=>15.44,
      :RecoveryRemaining=>0.0},
    ]

Soon it'll grab order and book statuses as well, and it may even allow
you to make web orders.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Be nice - this is my first gem!
