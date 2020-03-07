#A global  business user is set up with name Ambani to run these tests
#A business user should be able to create and see shops
Feature: Create shop as a business user

  As a business user
  After I login
  I should be able to create a shop
  when I go to shops link
  I should see shops name

    Scenario:
      When I am on the "log in" page
      And I enter the correct credential for global business user
      And I click the profile link for "business"
      And I click the new shops link
      And I enter the shop details with name "Shop name"
      And I click the "shops" link
      Then I should see "Shop name"

