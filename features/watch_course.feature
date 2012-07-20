Feature: Watch courses
  In Order to get updated by the website
  As a signed in user
  I want to watch courses I care

  Scenario: Watch course
    Given there is a course
    And I am signed in as a user
    When I watch the course
    Then I should see a notice about the course watched
