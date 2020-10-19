# AristoLms
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'aristo_lms', git: "https://github.com/lakesidelab/aristo_lms"
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install aristo_lms
```


to generate the initializer file run
```bash
$ rails g aristo_lms:install
```

In config/initializers/guider.rb set the name of your primary user model
```ruby
  AristoLms.user_class = "User"
```

then to generate all the migration files
```bash
$ rails aristo_lms:install:migrations
```

then finally create the tables
```bash
$ rails db:migrate
```

Once all that is done mount the engine in your main application in config/routes.rb
```ruby
  mount ArsitoLms::Engine => "/mount-url"
```
In app/models/your_user_model.rb, add This is done to create the association between the user and articles table
```ruby
has_many :aristo_lms_trainings, class_name: 'AristoLms::Training', foreign_key: :user_id
has_many :aristo_lms_subscriptions, class_name: 'AristoLms::Subscription', foreign_key: :user_id
has_many :aristo_lms_trainings, through: :aristo_lms_subscriptions
```

in your main application app/controllers/application_controller.rb add these two functions
```ruby
def current_user
  if user is logged_in
    @current_user = the user object
  else
    @current_user = nil  
  end  
end


def is_aristo_admin
  if user in session && some condition to access aristo_lms admin functionality
    return true
  else
    return false  
  end  
end  
```




##Routing
entry into admin module from main_app
```ruby
  aristo_lms.trainings_path
```

entry into player module from main_app
```ruby
  aristo_lms.subscriptions_path
```


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
