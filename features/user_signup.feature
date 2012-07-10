Feature: User signup
  In order to create stuffs like course on our site
  As a new user
  I want to signup to create my account

  Scenario: Sign up with Email
    Given the user don't have any account
    When the user sign up with Email and desired password
    Then the user has their account created
