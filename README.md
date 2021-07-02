# RailsGoat [![Build Status](https://api.travis-ci.org/OWASP/railsgoat.png?branch=master)](https://travis-ci.org/OWASP/railsgoat) [![Code Climate](https://codeclimate.com/github/OWASP/railsgoat.png)](https://codeclimate.com/github/OWASP/railsgoat)

RailsGoat is a vulnerable version of the Ruby on Rails Framework from versions 3 to 5. It includes vulnerabilities from the OWASP Top 10, as well as some "extras" that the initial project contributors felt worthwhile to share. This project is designed to educate both developers, as well as security professionals.

## CTF Instructions (WIP)

Level: Noob Town
  - Theme: Just Browsing
  - Hint: Look around the app for any suspicious information lying around.
  - Solution: Navigate to the bottom of the PTO tab.

Level: Toddler with an iPad
  - Theme: Sensitive Data Exposure
  - Hint: Look for suspicious CSS classes
  - Solution: Use Inspector to find the hidden CSS class of the SSN column in the Work Info tab.

Level: Have Read Bloody Monday
  - Theme: Sensitive Data Exposure
  - Hint: Look for privileged routes that aren't properly protected.
  - Solution: Navigate to get_all_users and look for a user with exposed Secure UUID.

Level: Security Engineer at SolarWinds
  - Theme: Security Misconfiguration
  - Hint: If configured incorrectly, an application will display a full trace instead of a 404 page.
  - Solution: Go to a non-existent path and look for a flag in the list of routes.

Level: Dollar Store Neo
  - Theme: User Access Control
  - Hint: There is an admin-level page that is missing proper access controls.
  - Solution: Go to /admin/1/dashboard from any non-admin user.

Level: NSA Watchlist
  - Theme: Insecure Direct Object Reference
  - Hint: There is a file secret_token.rb which contains sensitive information.
  - Solution: Use the link for downloading files in the Benefit Forms tab and replace the file name with secret_token.rb.

Level: Greensky Corporate Spy
  - Theme: Unvalidated Redirects and Forwards
  - Hint: Try redirecting a user to our company's website.
  - Solution: Go to /login?url=https://financeit.io and login as a valid user.

Level: Gandalf the Grey-Hat Hacker
  - Theme: DOM or Python XSS (Cross-Site Scripting)
  - Hint: You can execute remote commands by browsing to /#test=<script>...</script>.
  - Solution: Go to /#test=<script>alert(document.cookie)</script>.

Level: Gandalf the White-Hat Hacker
  - Theme: Stored XSS (Cross-Site Scripting)
  - Hint: When creating new objects in the DB, you can store JS as an attribute which will be executed whenever it's called.
  - Solution: Sign up with a new user with a First Name of "<script>alert(document.cookie)</script>".

Level: Gandalf the Black-Hat Hacker
  - Theme: Reflected XSS (Cross-Site Scripting)
  - Hint: Uploading files can be used to inject a JS alert. The document's cookie is a good place to start.
  - Solution: Upload a file named "><img src=1 onerror=alert(document.cookie)>" to the Benefit Forms tab.

Level: NSA Most Wanted
  - Theme: Cross-Site Request Forgery (CSRF)
  - Hint: The Pay model has a hidden attribute called show_secure_token which is automatically false if created through the Pay tab.
  - Solution: Open a script HTML file to create a Pay object with show_secure_token set to true.

Level: Cyberpunk 2078
  - Theme: Missing Function Level Access Control
  - Tools: Chrome Inspector or Burpsuite
  - Hint: Send a tampered message masquerading as another user. View the message.
  - Solution: Send a message normally and intercept the POST request. Modify the creator_id to another user and send the request.

Level: Destin's Reincarnation
  - Theme: SQL Injection / Privilege Escalation
  - Tools: Chrome Inspector
  - Hint: Use the password change function to change the admin's password. Browse for the flag on privileged pages.
  - Solution: Intercept a password change POST and modify the user_id with "999') OR admin = 't' --'")". Navigate to Analytics tab.

Level: Power Level Integer Overflow
  - Theme: Broken Session Management / Privilege Escalation
  - Tools: Burpsuite
  - Hint: This application re-uses encryption keys for auth tokens. The admin has a user_id of 1.
  - Solution: Create a Pay object with all attributes set to 1. Modify the encrypted key to be url-encoded and intercept a GET request with Burpsuite. Navigate to Dashboard tab as admin.

Level: Ne Plus Ultra
  - Theme: Command Injection
  - Tools: Burpsuite
  - Hint: Create a directory called "mischiefmanaged" on the server.
  - Solution: Intercept an upload/download request, modify the "benefits[backup]" to true, and append ";+mkdir+mischiefmanaged" to the filename. Navigate to Benefit Forms tab.




## Support

If you are looking for support or troubleshooting assistance, please visit our [OWASP Slack Channel](https://owasp.slack.com/messages/project-railsgoat/).

## Getting Started

To begin, install the Ruby Version Manager (RVM):

```bash
$ curl -L https://get.rvm.io | bash -s stable --autolibs=3 --ruby=2.3.5
```

After installing the package, clone this repo:

```bash
$ git clone git@github.com:OWASP/railsgoat.git
```

**NOTE: NOT NECESSARY IF YOU WANT TO WORK WITH RAILS 5.** Otherwise, if you wish to use the Rails 3 or 4 versions, you'll need to switch branches:

```bash
$ cd railsgoat
$ git checkout rails_3_2
$ git checkout rails_4_2
```

Navigate into the directory (already there if you followed the previous step) and install the dependencies:

```bash
$ bundle install
```

If you receive an error, make sure you have `bundler` installed:

```bash
$ gem install bundler
```

Initialize the database:

```bash
$ rails db:setup
```

Start the Thin web server:

```bash
$ rails server
```

Open your favorite browser, navigate to `http://localhost:3000` and start hacking!

## Vagrant Install

To run Railsgoat with Vagrant you must first have [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/) installed. Once those dependencies are installed cd into the Railsgoat directory where you've cloned the code and run.

```
#~/code/railsgoat
$ vagrant up
...
    railsgoat:   Port: 3000:3000
    railsgoat:
    railsgoat: Container created: 3084633a81675346
==> railsgoat: Starting container...
==> railsgoat: Provisioners will not be run since container doesn't support SSH.
$
```
Once you see the preceeding message Railsgoat is running on your localhost on port 3000.

Open your favorite browser, navigate to `http://localhost:3000` and start hacking!

## Docker Install
To run Railsgoat with Docker you must first have [Docker](https://docs.docker.com/engine/installation/) and [Docker Compose](https://docs.docker.com/compose/install/) installed. Once those dependencies are installed, cd into the Railsgoat directory where you've cloned the code and run. Rails requires Compose **1.6.0** or above and require a Docker Engine of version **1.10.0** or above.

```
#~/code/railsgoat
$ docker-compose build
$ docker-compose run web rails db:setup
$ docker-compose up
...
  Creating railsgoat_web_1
  Attaching to railsgoat_web_1
$
```
Once you see the preceeding message Railsgoat is running on your localhost on port 3000.

Open your favorite browser, navigate to `http://<dockerIP>:3000` and start hacking! The Docker IP is usually `192.168.99.100`. Run `docker-machine env` to verify.

Note: if your container exits with an error, it may be because a server is already running:
```
A server is already running. Check /myapp/tmp/pids/server.pid.
=> Booting Thin
=> Rails 5.0.1 application starting in development on
http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
Exiting
```
In this case, remove that server.pid file and try again. Note also that this file is in your current working directory, not inside the container.

## Capybara Tests

RailsGoat now includes a set of failing Capybara RSpecs, each one indicating that a separate vulnerability exists in the application. To run them, you first need to install [PhantomJS](https://github.com/jonleighton/poltergeist#installing-phantomjs) (version 2.1.1 has been tested in Dev and on Travis CI), which is required by the Poltergeist Capybara driver. Upon installation, simply run the following task:

```
$ rails training
```

To run just one spec:

```
$ rails training SPEC=spec/vulnerabilities/sql_injection_spec.rb
```

NOTE: As vulnerabilities are fixed in the application, these specs will not change to `passing`, but to `pending`.


## MySQL Environment

By default in development mode Railsgoat runs with a SQLite database. There is an environment defined to use MySQL. For some of the SQL injection vulnerabilities to work you have to run the app with MySQL as the database. The following steps will setup and run Railsgoat to use MySQL. *MySQL must be installed and running before running these steps*

```
#Create the MySQL database
RAILS_ENV=mysql rails db:create

#Run the migrations against the database
RAILS_ENV=mysql rails db:migrate

#Boot Rails using MySQl
RAILS_ENV=mysql rails s
```

## Processing Email

In order for RailsGoat to effectively process email, you will first need to run MailCatcher, an SMTP server that will intercept email messages and display them in a web interface.

Mailcatcher is not installed by default. To install MailCatcher and start an instance of it, simply run:

```
$ gem install mailcatcher
$ mailcatcher
```

If successful, you should see the following output:

```
Starting MailCatcher
==> smtp://127.0.0.1:1025
==> http://127.0.0.1:1080
*** MailCatcher runs as a daemon by default. Go to the web interface to quit.
```

Alternatively, you can run MailCatcher in the foreground by running `mailcatcher -f` in your terminal.

## Contributing

As changes are made to the application, the Capybara RSpecs can be used to verify that the vulnerabilities in the application are still intact. To use them in this way, and have them `pass` instead of `fail`, set the `RAILSGOAT_MAINTAINER` environment variable.

Conversion to the OWASP Top Ten 2013 completed in November, 2013.

# License

The MIT License (MIT)

Copyright (c) 2013-2014 The Open Web Application Security Project

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
