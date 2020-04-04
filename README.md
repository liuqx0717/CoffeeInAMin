# README

Team Members:

Quanxing Liu (ql2368)

Reshma Asharaf Beena (ra3027)

Xin Gu (xg2327)

Heroku url : https://sheltered-everglades-13750.herokuapp.com/

**Iteration 1 features**

(1) Register and login (for business user and customer)

(2) Business User:

	(a) Create account
	(b) Update account details
	(c) Create shop	
	(d) Update shop details
	(e) Add menu
	(f) Update menu
	(g) See orders placed by customers
(3) Customer:

	(a) Create account
	(b) Update account details
	(c) See all shops
	(d) See menu per shop
	(e) Place order
	(f) See orders placed
	
**Iteration 2 features**

(1) Improvement of user authentication:

    (a) The passwords are saved using SHA256, instead of plain text
    (b) Customers now have an option to login to the platform using Google accounts
    
(2) Navigation:

    (a) Integration with google maps
    (b) Derive coodinates in maps from address of shop, and calculate the distance
        from the user
    (c) Help users to navigate from their current location to shop
    
(3) Process payment of orders:

    (a) Stripe integration to process order payment
     
     
 (4) Cucumber tests for features
 
 (5) css
 
Note:
    To run the tests, you need to install Qt5 development package and Qt5 Webkit
    package. (e.g. qt5-devel and qt5-qtwebkit-devel in Fedora)
