# Controllers 

Each sinatra route can be considered its own controller in a typical MVC (model, view, controller) setup. The name controller/route is pretty much interchangeable in this sense when trying to translate the ideas of an MVC type setup.

## Simple Example Use

```ruby
require 'sinatra'

get "/index" do
  "A working controller!"
end
```

## Boilerplate Controllers

Within this boilerplate sinatra application, we have a view controllers/routes pre-defined. These can be removed / modified to fit the needs of your application or be used as blueprints to build your own. Keep in mind, you need to register and require any other custom controllers you end up making as well as removing any from the main `app.rb` that you remove.

```
controllers/
├── about.rb
├── errors.rb
├── index.rb
└── sessions.rb
```

### index.rb

This controller is setup to maintain the main indexing of your application such as the homepage.

### errors.rb

This controllers handles special errors such as when something is not found or an internal server error.

### about.rb

This controller acts as an example sort of normal controller you may have in your application to describe the subject of the web application.

### session.rb

This controller handles all the logging in and logging out a user may do during the use of the application.
