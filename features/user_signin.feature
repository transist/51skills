Feature: User signin
  In order to watch or enroll courses in the website
  As a existing user
  I should be able to sign in with my account

  Scenario: Sign in with email
    Given there is a user
    When I sign in with email and password of the user
    Then I should be signed in

  Scenario: Sign in with email from a specific page
    Given there is a user
    And there is a course
    And I am on the course page
    When I sign in with email and password of the user
    Then I should be signed in
    And I should be on the course page
