# phpTravelsTests

### Site: http://www.phptravels.net/supplier
(Demo site of http://phptravels.com/demo/)

### Approach for testing:
* Create requirements matrix
* Review requirements matrix
* Document test cases pertaining to major functionality
* Document test cases pertaining to minor functionality
* Map test cases within requirements matrix

### Two features selected for testing:
* **Features:** Create Bookings, Manage Bookings
* Ensure unit test coverage for Hotels and Flights features
* Use requirements matrix in order to create functional test plan for associated features (**Requirements.txt**)
* Create automated functional tests for associated features

### Tools:
* Capybara (Selenium/Chrome driver)
* Cucumber
* RSpec

### Running tests:
In order to run the tests, run
```
bundle install && cucumber
```

Please see **booking.feature** and **management.feature** to review the automated tests that were created.