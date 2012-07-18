Feature: Enroll Course
  In order to attend a course
  As a user
  I want to enroll course
  
  Scenario:
    Given there is a scheduled course
    And I am signed in as a user
    When I enroll the course
    Then I should see a notice about the course enrolled