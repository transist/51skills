Feature: User signin
  In order to create stuffs like course on our site
  As a existing user
  I should be able to sign in with my account

  Scenario: Sign in with email
    Given there is a user
    When I sign in with email and password of the user
    Then I should be signed in
