Feature: See the homepage

  As a user
  when I go to root url
  I should see the home page

  Scenario: log in with right credentials
    Given I am on the "home" page
    Then I should see "Tired of waiting for 10 miniutes after ordering a cup of coffee"

