Feature: Login

  As a new user
  To use CoffeeInAMin
  I want to register

  Scenario: I start a new game

    Given I am on the home page
    And I press "New Game"
    Then I should see "Guess a letter"
    And I press "New Game"
    Then I should see "Guess a letter"
