pocket-ruby
===========

[![Code Climate](https://codeclimate.com/github/turadg/pocket-ruby.png)](https://codeclimate.com/github/turadg/pocket-ruby) [![Gem Version](https://badge.fury.io/rb/pocket-ruby.png)](http://badge.fury.io/rb/pocket-ruby)

Ruby API for v3 of the [Pocket API](http://getpocket.com/developer/docs/overview) (formerly Read It Later) 

# Usage

Just clone the repo here and refer to the demo-server.rb file for examples on how to interact with the Pocket API. 

```sh
	git clone
	cd pocket-ruby
	bundle install
	ruby demo-server.rb
```

Pocket-Ruby can be installed via the gem, ```gem install pocket-ruby```

Or via bundler, ```gem 'pocket-ruby'```

# For v0.0.5 and earlier

Using v0.0.5 and earlier may result in a ```require``` error. To fix this you may either update to a newer version of the gem or uninstall with ```gem uninstall pocket-ruby``` and try again using the method below:

Install via the gem, ```gem install pocket-ruby -v 0.0.5```

Or via bundler, ```gem 'pocket-ruby', '0.0.5', :require => 'pocket'```

Be sure to require the gem in your code with ```require 'pocket'``` not ```require 'pocket-ruby'```
