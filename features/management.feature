Feature: Booking Management

Scenario: Navigate to edit booking page and ensure details are displayed
    Given I navigate to the supplier dashboard page
    When I login using valid credentials
    And I click the "Bookings" button
    And I store the booking infomration for the booking on row 1
    And I click the edit button for the booking on row 1
    Then the edit booking page should be displayed
    And the edit booking page should display the correct total price

Scenario: Delete a booking and esure that the booking is removed
    Given I navigate to the supplier dashboard page
    When I login using valid credentials
    And I click the "Bookings" button
    And I store the booking infomration for the booking on row 1
    And I click the delete button for the booking on row 1
    And I accept the confirmation alert
    Then the booking is successfully deleted from row 1
