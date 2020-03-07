Feature: log in for customer

  As a customer
  After I register
  when I enter the correct credentials
  I will be able to login
  when I enter the incorrect credentials
  I will get a message asking to register

  Scenario: log in with right credentials
    Given I create a valid account for user
    When I am on the "log in" page
    And I enter the correct credential for user
    Then I should see "Logged In!! Welcome :)"

  Scenario: log in with incorrect credentials
    When I am on the "log in" page
    And I enter the incorrect credential
    Then I should see "User not registered, we would love to have you onboard!"
