# README

Team Members:

Quanxing Liu (ql2368)

Reshma Asharaf Beena (ra3027)

Xin Gu (xg2327)

Heroku url : https://sheltered-everglades-13750.herokuapp.com/

**How to run the app**

1. Install Ruby

2. Install packages: `bundle install --path vendor/bundle`

3. Add `master.key` to `config/`. This file is included in the submitted zip. We did not push it to GitHub for security.

4. Migrate database: `bundle exec rake db:migrate`

5. Run Rails server: `bundle exec rails server`

6. To run the tests: (e.g.) `bundle exec cucumber features/menus_and_orders.feature`

**Iteration 1 Features**

1. Register and login (for business user and customer)

2. Business User:

	(a) Create account
	(b) Update account details
	(c) Create shop	
	(d) Update shop details
	(e) Add menu
	(f) Update menu
	(g) See orders placed by customers
3. Customer:

	(a) Create account
	(b) Update account details
	(c) See all shops
	(d) See menu per shop
	(e) Place order
	(f) See orders placed
	
**Iteration 2 Features**

1. Improvement of user authentication:

    (a) The passwords are saved using SHA256, instead of plain text
    (b) Customers now have an option to login to the platform using Google accounts
    
2. Navigation:

    (a) Integration with google maps
    (b) Derive coodinates in maps from address of shop, and calculate the distance
        from the user
    (c) Help users to navigate from their current location to shop
    
3. Process payment of orders:

    (a) Stripe integration to process order payment
     
     
4. Cucumber tests for features
 
5. css
 
Note:
    To run the tests, you need to install Qt5 development package and Qt5 Webkit
    package. (e.g. qt5-devel and qt5-qtwebkit-devel in Fedora)

**Final Submission Features**

1. QR code to track paid orders

    (a) Customers can get a QR code for their paid order.
    (b) Merchants can scan a QR code to finish an order when the customer comes and takes away the ordered coffee.

2. Delay the payment

    (a) Customers can pay for an order later. There will be a "Pay Now" button at the orders page.

3. Picture for shops and items

    (a) Merchants can add/modify the pictures for their shops and items.

4. css

**The Structure of This App**

1. Database: see `app/models/`. Each table in database has one corresponding model in this directory.

2. APIs: see `config/routes.rb`. This file contains the mappings from url to controller/action.

3. Front end: we use Bootstrap. The master page is `app/views/layouts/application.html.haml`, which contains navigation bar, footer, and necessary headers/css for all the pages. The other views in `app/views` will fill their content in the master page.
