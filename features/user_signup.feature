Feature: User signup
  In order to create stuffs like course on our site
  As a new user
  I want to signup to create my account

  Scenario: Sign up with Email
    Given I don't have any account
    When I sign up with Email and desired password
    Then I have my account created
