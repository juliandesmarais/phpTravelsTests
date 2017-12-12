Feature: Booking (Cars, Hotels, Tours)

Scenario Outline: Create a car booking for a registered user
    Given I navigate to the supplier dashboard page
    When I login using valid credentials
    And I navigate to the Quick Booking page for the Cars service
    And I set the rental date to be a valid future date
    And I set the car to <car_type>
    And I set the extras to <extras>
    And I click the "Book Now" button
    Then the booking management page should be displayed

    Examples:
    | car_type         | extras |
    | Opel Astra 2014  | on     |
    | Ford Mondeo 2012 | off    |
    | Ford Focus 2014  | on     |

Scenario Outline: Create a hotel booking for a registered user
    Given I navigate to the supplier dashboard page
    When I login using valid credentials
    And I navigate to the Quick Booking page for the Hotels service
    And I set the check in date to be a valid future date
    And I set the hotel to <hotel_name>
    And I set the room type to <room_type>
    And I click the "Book Now" button
    Then the booking management page should be displayed

    Examples:
    | hotel_name               | room_type            |
    | Rendezvous Hotels        | Delux Room           |
    | Hyatt Regency Perth      | Standard Room        |
    | Islamabad Marriott Hotel | Superior Single View |

Scenario Outline: Create a tour booking for a registered user
    Given I navigate to the supplier dashboard page
    When I login using valid credentials
    And I navigate to the Quick Booking page for the Tours service
    And I set the tour date to be a valid future date
    And I set the tour to <tour_name>
    And I click the "Book Now" button
    Then the booking management page should be displayed

    Examples:
    | tour_name                       |
    | 6 Days Around Thailand          |
    | Hong Kong Island Tour           |
    | Sydney and Bondi Beach Explorer |
