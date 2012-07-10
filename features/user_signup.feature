Feature: Person signup
  In order to create stuffs like course on our site
  As a new person
  I want to signup to create my account

  Scenario: Sign up with Email
    Given the person don't have any account
    When the person sign up with Email and desired password
    Then the person has their account created
