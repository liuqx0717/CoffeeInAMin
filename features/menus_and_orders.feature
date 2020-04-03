#A global customer is set up with name John to run these tests
#A customer user should be able to go to shop menu and create and see his/her orders
Feature: Create order as a customer

  As a business user
  After I login
  when I go to shop menu
  and click menu
  I should be able to place an order and make payment
  when I click to orders menu after this
  I should see my order

  @javascript
  Scenario:
    Given my IP address is "158.222.139.241"
    When I am on the "log in" page
    And I enter the correct credential for global customer
    And I click the profile link for "user"
    And I click the "shops" link
    And I click the test shops link
    And I click the test menu link
    Then I should see "Coffee"
    And I click the test item link
    And I place the order
    And enter user details
    And I fill in card details in stripe
    And I submit the stripe form
    And I click the "orders" link
    Then I should see "Coffee"


