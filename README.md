# rshark

A ruby packet anaylsis web application providing an intuitive platform to peform various packet anaylisis taks wrapped together in a slick, boostrap front-end.  

### Sinatra

This web application utilizes sinatra, a DSL for quickly creating web applications in Ruby with minimal effort. I choose sinatra to implement this application since it's traditionally a light-weight alternative to something like rails; and I was more than prepared to bring my own logic to the table to create a fully functional application from - what could be loosely considered - from scratch. 

### Boostrap 3

Boostrap 3.3.7 was choosen to act as our front-end framework to help thing look pretty with ease. Moreover, it's pretty much the most popular HTML, CSS, and JS framework for developing responsive, mobile first projects on the web -- and so, we thought would be a perfect platform to add some style to packet analysis..

### Packetfu

This application relies heavily on the work done by Tod Beardsley and the awesome contributors to the Packetfu ruby gem. It's an awesome library for reading and writing packets to an interface or to a libpcap-formatted file; and, in our case, allows us to inspect and anaylze packet information via an intuitive Ruby API.

### Chartkick

Chartkick provided beautiful, elegant Javascript charts with one line of Ruby. We loved discovering this library during my time figuring out how I wanted to display my packet anaylsis data to users. If Ruby isn't your thing, it is also available in Python, JavaScript, React, Vue.js, and Elixir.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rshark'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rshark

## Usage

To jumpstart your usage of rshark, we can do something like this:

```shell
$ git clone https://github.com/picatz/rshark.git
$ cd rshark/
$ ruby app.rb
== Sinatra (v1.4.6) has taken the stage on 4567 for production with backup from Thin
Thin web server (v1.7.0 codename Dunder Mifflin)
Maximum connections set to 1024
Listening on 0.0.0.0:4567, CTRL+C to stop
127.0.0.1 - - [03/Dec/2016:16:44:38 -0500] "GET / HTTP/1.1" 200 2712 0.0211
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

