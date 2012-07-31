Feature: Disenroll Course
  In order to give up a course
  As a user
  I should be able to disenroll course

  Scenario: Disenroll a free course
    Given there is a scheduled free course
    And I am signed in as a user
    And I already enrolled the course
    When I disenroll the course
    Then I should see a notice about the course disenrolled

  Scenario: Disenroll a course with incomplete payment
    Given there is a scheduled course
    And I am signed in as a user
    And I already enrolled the course without complete the payment
    When I cancel the payment
    Then I should see a notice about the course disenrolled
