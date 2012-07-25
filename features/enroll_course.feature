Feature: Enroll Course
  In order to attend a course
  As a user
  I want to enroll course

  Scenario: Enroll a course
    Given there is a scheduled course
    And I am signed in as a user
    When I enroll the course
    Then I should see a notice about the course enrolled

  Scenario: Disenroll a course
    Given there is a scheduled course
    And I am signed in as a user
    And I already enrolled the course
    When I disenroll the course
    Then I should see a notice about the course disenrolled
