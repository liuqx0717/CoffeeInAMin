require 'cucumber/rspec/doubles'
Before do

  @business_user = User.new
  @business_user.email = 'Ambani@email.com'
  @business_user.name = 'Ambani'
  @business_user.password = Digest::SHA2.hexdigest('Ambanipwd')
  @business_user.user_type = 1
  @business_user.save

  @customer_user = User.new
  @customer_user.email = 'John@email.com'
  @customer_user.name = 'John'
  @customer_user.password = Digest::SHA2.hexdigest('Johnpwd')
  @customer_user.user_type = 0
  @customer_user.save

  @shop = Shop.new
  @shop.name = "Test shop"
  @shop.address = "Columbia University, New York"
  @shop.description = "Test description"
  @shop.owner_id = @business_user.id
  @shop.save

  @item = Item.new
  @item.name = "Coffee"
  @item.description = "Regular coffee"
  @item.price = 10.00
  @item.shop_id = @shop.id
  @item.save

end

Given /^my IP address is "(.*?)"$/ do |ip|
  ActionDispatch::Request.any_instance.stub(:ip).and_return(ip)
end

After do
  User.destroy_all
end

Then("I should see {string}") do |string|
  if page.respond_to? :should
    page.should have_content(*string)
  else
    assert page.has_content? string
  end
end

When(/^I am on the "([^"]*)" page$/) do |arg|
  if arg == 'log in'
    visit '/session'
  elsif arg == 'home'
    visit '/'
  end
end

And(/^I create a valid account for business$/) do
  visit '/users/new'
  fill_in 'email', with: 'business@email.com'
  fill_in 'password', with: '123'
  fill_in 'name', with: 'BusinessUser'
  choose 'user_type_1'
  click_button 'Register'
end

And(/^I create a valid account for user$/) do
  visit '/users/new'
  fill_in 'email', with: 'reshma@email.com'
  fill_in 'password', with: '123'
  fill_in 'name', with: 'Reshma'
  choose 'user_type_0'
  click_button 'Register'
end

And(/^I enter the correct credential for user$/) do
  visit '/session'
  fill_in 'Email', with: 'reshma@email.com'
  fill_in 'Password', with: '123'
  click_button 'Login'
end

And(/^I enter the correct credential for business$/) do
  visit '/session'
  fill_in 'Email', with: 'business@email.com'
  fill_in 'Password', with: '123'
  click_button 'Login'
end

And(/^I enter the correct credential for global business user$/) do
  visit '/session'
  page.driver.browser.set_cookie("user_id=#{@business_user.id}")
  fill_in 'Email', with: 'Ambani@email.com'
  fill_in 'Password', with: 'Ambanipwd'
  click_button 'Login'
end

And(/^I enter the correct credential for global customer$/) do
  visit '/session'
  page.driver.browser.set_cookie("user_id=#{@customer_user.id}")
  fill_in 'Email', with: 'John@email.com'
  fill_in 'Password', with: 'Johnpwd'
  click_button 'Login'
end

And(/^I enter the shop details with name "([^"]*)"$/) do |arg|
  fill_in 'Name', with: arg
  fill_in 'Address', with: 'Columbia University, New York'
  fill_in 'Description', with: 'Coffee Shop : Blue Java in Mudd'
  click_button 'Add'
end

And(/^I place the order$/) do
  click_button 'Order Now'
end

And(/^enter user details$/) do
  # sleep(5)
  # click_button 'Pay with Card'
  # page.driver.find_element(css: '.stripe-button-el')
  #
  #

  fill_in 'Full name', with: @customer_user.name
  fill_in 'Telephone', with: '12345678'
  sleep(5)
  # find('button.stripe-button-el').click
  # click_button 'Pay with Card'
  # click_on(class: '.stripe-button-el')
  # # find('.stripe-button-el').click
  elem = page.driver.find_element(:text, "Pay with Card")
  puts(elem)
end

And(/^I fill in card details in stripe/) do
  sleep(0.1) until page.evaluate_script('$.active') == 0
  @stripe_iframe = all('iframe[name=stripe_checkout_app]').last
  within_frame @stripe_iframe do
    fill_in 'Email', with: 'some_email@email.com'
    fill_in 'Card number', with: '4242 4242 4242 4242'
    fill_in 'CVC', with: '123'
    fill_in 'cc-exp', with: '12/2022'
  end
end

And(/^I submit the stripe form$/) do
  within_frame @stripe_iframe do
    click_button "Pay $#{@item.price}"
  end
  sleep(1)
end


And(/^I enter the incorrect credential$/) do
  fill_in 'Email', with: 'some_incorrect_email'
  fill_in 'Password', with: 'some_incorrect_passcode'
  click_button 'Login'
end

When(/^I click the profile link for "([^"]*)"$/) do |arg|
  if arg == "business"
    visit '/users/'+ @business_user.id.to_s
  else
    visit '/users/'+ @customer_user.id.to_s
  end
end


When(/^I click the new shops link$/) do
  visit '/shops/new/'
end

When(/^I click the test shops link$/) do
  visit '/shops/'+@shop.id.to_s
end

When(/^I click the test menu link$/) do
  visit '/shops/'+@shop.id.to_s+'/menu'
end

When(/^I click the test item link$/) do
  visit '/items/'+@item.id.to_s
end

When(/^I click the "([^"]*)" link$/) do |arg|
  if arg == "orders"
    visit '/orders'
  elsif arg == "shops"
    visit '/shops/'
  end
end

