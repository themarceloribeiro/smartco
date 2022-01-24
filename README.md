### Webserver log parser

The goal for this app is to parse a webserver.log file and return the list of webpages with most page views, ordered from most page views to less page views

### Setup

Start by installing rvm if you don't have it installed yet. Instructions found here[https://rvm.io/rvm/install].

Once rvm is installed, make sure you have ruby 3 installed:

```
rvm install 3
```

Then go ahead and install bundler, and the dependencies for your app.

```
cd smartco
rvm install 
gem install bundler -v=2.3.5
bundle
```

### Running the app

```
./parser.rb webserver.log
```

### Running specs

```
rspec spec
```
