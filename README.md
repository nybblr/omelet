Omelet
======
An OpenSource report queueing and generation server, powered by Ruby on Rails.

Brought to you by 5 cheese-loving GT students.

Installation
============
Assuming you have a functioning Ruby and Rails installation, you will also need a Redis server installed and configured.

There are 3 components to Omelet:

1. The queue server (this gem) --- this is run as a single daemon on the host server and responds to requests from any web app on the same server. Get redis and Resque running with `foreman start`, then run the rails app with `rails server`.
2. The UI engine (omelet_ui). Bundle the repository in your host app and mount it (more below).
3. Your host application. This is the app that will be providing data and hooks to report generation; mount omelet_ui (examples below), provide a configuration initializer, and build some report templates. For reference, checkout omelet_example for a fully functioning example host app.

To add omelet_ui into your host app, add it to your Gemfile:
``` ruby
gem 'omelet_ui', :git => "git://github.com/nybblr/omelet_ui"
```

omelet_ui will need a database table for your templates, so install migrations with:
``` bash
rake omelet_ui:install:migrations
```

Mount the interface to a path of your choosing, such as:
``` ruby
### config/routes.rb
mount Resque::Server.new, :at => "/resque"
```

Last, install an initializer to specify basic parameters:
``` ruby
### config/initializers/omelet_ui.rb
OmeletUi.setup do |config|
	# Address for the queue server
	config.server = "http://localhost:9292/"

	# Unique ID to identify app's reports on queue server
	config.app_id = "oss.nybblr.Omelet.Example"

	# Set the current_user method for User ID
	# config.current_user = :current_user

	# Set the identifier method for User ID
	# config.identifier = :identifer

	# Set the app name
	config.app_name = "Atari"

	# Set the app homepage
	config.home_path = "/"
end
```


