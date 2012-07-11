Install Prerequisites
=====================

The prerequisites are required both for development workstation.

* QT4 development package for capybara-webkit. (libqt4-dev on Ubuntu)
* node.js for compile CoffeeScript.
* Redis for resque.

Run Rails server
================

    # Linux user run this:
    bundle install --without darwin

    # Mac OS X user run this:
    bundle install --without linux

    rails s

Continuously run tests with Spork
=================================

Watch source files change, run modified features, modified or related specs
automatically. Press `Enter` to run all specs and features.

    bundle exec guard

Manually run tests
==================

    bundle exec rspec && bundle exec cucumber

*vim: set tw=78:*
