Feature: Create Course
  In order to show users course information
  As an admin
  I want to create a course
  
  @javascript
  Scenario: create a course
    Given I am signed in as an admin
    And meta data for course creation
    When I create a course
    Then course should be created

  Scenario: change a course state from inactive to active
    Given I am signed in as an admin
    And there is an inactive course
    When I activate the inactive course
    Then the course state should be changed to active