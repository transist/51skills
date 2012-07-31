Feature: Enroll Course
  In order to attend a course
  As a user
  I want to enroll course

  @mechanize
  Scenario: Enroll a course with payment
    Given there is a scheduled course
    And I am signed in as a user
    When I enroll the course
    And I pay for the course via Alipay
    Then I should see a notice about the course enrolled
    And the status of the enrollment should be paid

  @mechanize
  Scenario: Enroll a course with incomplete payment
    Given there is a scheduled course
    And I am signed in as a user
    When I enroll the course
    And I view course page without complete the payment
    Then I should see payment button and cancel button

  @mechanize
  Scenario: Complete an incomplete payment
    Given there is a scheduled course
    And I am signed in as a user
    When I enroll the course
    And I view course page without complete the payment
    And I complete the payment
    Then I should see a notice about the course enrolled
    And the status of the enrollment should be paid

  Scenario: Enroll a free course
    Given there is a scheduled free course
    And I am signed in as a user
    When I enroll the course
    Then I should see a notice about the course enrolled
    And the the enrollment can be disenrolled
