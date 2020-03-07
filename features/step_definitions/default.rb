
Before do
  @business_user = User.new
  @business_user.email = 'Ambani@email.com'
  @business_user.name = 'Ambani'
  @business_user.password = 'Ambanipwd'
  @business_user.user_type = 1
  @business_user.save

  @business_user = User.find_by email: 'Ambani@email.com'
  page.driver.browser.set_cookie("user_id=#{@business_user.id}")

  @customer_user = User.new
  @customer_user.email = 'John@email.com'
  @customer_user.name = 'John'
  @customer_user.password = 'Johnpwd'
  @customer_user.user_type = 0
  @customer_user.save

  @customer_user = User.find_by email: 'John@email.com'
  page.driver.browser.set_cookie("user_id=#{@customer_user.id}")

  @shop = Shop.new
  @shop.name = "Test shop"
  @shop.address = "Test address"
  @shop.description = "Test description"
  @shop.owner_id = @business_user.id
  @shop.save

  @shop = Shop.find_by name: 'Test shop'
  @item = Item.new
  @item.name = "Coffee"
  @item.description = "Regular coffee"
  @item.price = 10
  @item.shop_id = @shop.id
  @item.save


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
  fill_in 'Email', with: 'Ambani@email.com'
  fill_in 'Password', with: 'Ambani'
  click_button 'Login'
end

And(/^I enter the correct credential for global customer$/) do
  visit '/session'
  fill_in 'Email', with: 'John@email.com'
  fill_in 'Password', with: 'John'
  click_button 'Login'
end

And(/^I enter the shop details with name "([^"]*)"$/) do |arg|
  fill_in 'Name', with: arg
  fill_in 'Address', with: 'Shop Address'
  fill_in 'Description', with: 'Description'
  click_button 'Add'
end

And(/^I place the order$/) do
  click_button 'Order Now'
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
  page.driver.browser.set_cookie("user_id=#{@business_user.id}")
  visit '/shops/new/'
end

When(/^I click the test shops link$/) do
  page.driver.browser.set_cookie("user_id=#{@customer_user.id}")
  visit '/shops/'+@shop.id.to_s
end

When(/^I click the test menu link$/) do
  page.driver.browser.set_cookie("user_id=#{@customer_user.id}")
  visit '/shops/'+@shop.id.to_s+'/menu'
end

When(/^I click the test item link$/) do
  page.driver.browser.set_cookie("user_id=#{@customer_user.id}")
  visit '/items/'+@item.id.to_s
end

When(/^I click the "([^"]*)" link$/) do |arg|
  if arg == "orders"
    page.driver.browser.set_cookie("user_id=#{@customer_user.id}")
  visit '/orders'
  elsif arg == "shops"
    visit '/shops/'
  end
end

