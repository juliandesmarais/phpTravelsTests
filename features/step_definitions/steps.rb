require_relative '../support/utils.rb'

stored_booking = nil
stored_id = ""
class Booking_Information
    attr_accessor :id
    attr_accessor :ref
    attr_accessor :customer
    attr_accessor :module
    attr_accessor :date
    attr_accessor :total
end

def get_booking_info(row)
    all_rows = page.all('tr')
    within(all_rows[row.to_f]) do
        all_data = page.all('td')
        booking_info = Booking_Information.new
        booking_info.id = all_data[2].text
        booking_info.ref = all_data[3].text
        booking_info.customer = all_data[4].text
        booking_info.module = all_data[5].text
        booking_info.date = all_data[6].text
        booking_info.total = all_data[7].text
        puts "Booking ID: " + booking_info.id
        puts "Booking ref: " + booking_info.ref
        puts "Booking customer: " + booking_info.customer
        puts "Booking module: " + booking_info.module
        puts "Booking date: " + booking_info.date
        puts "Booking total: " + booking_info.total
        return booking_info
    end
end

# URLs
DASHBOARD_URL = "http://www.phptravels.net/supplier"

# Constants
VALID_EMAIL = "supplier@phptravels.com"
VALID_PASSWORD = "demosupplier"

QUICK_BOOKING_BTN = "Quick Booking"
MGMT_BTN = "Bookings"
MGMT_TEXT = "Booking Management"
EDIT_BOOKING_TEXT = "Edit Booking"
NEXT_BTN = "Next"

# Selectors
SL_EDIT = '.fa-edit'
SL_DELETE = '.fa-times'
SL_DELETE_CONFIRM = '.ui-pnotify-title'
SL_CAR_RESERVE_DATE = 'input[id="Cars"]'
SL_GRAND_TOTAL = 'td#grandtotal'
SL_TOUR_RESERVE_DATE = ''
SL_CALENDAR_NEXT = '.next'
SL_VALID_DATE = 'div.datepicker-days tr:nth-child(1) td:nth-child(2)'
SL_GRAND_TOTAL = 'td[id="grandtotal"]'
SL_CHECKIN = 'input[name="checkin"]'
SL_CHECKOUT = 'input[name="checkout"]'

SL_SELECT_ITEM = "select[name='item']"
SL_SELECT_ROOM_TYPE = "select[id='poprooms']"
SL_SELECT_SERVICE = "select[name='service']"

# Steps
Given(/^I navigate to the supplier dashboard page$/) do
    visit DASHBOARD_URL
end

When(/^I click the "(.*?)" button$/) do |button|
    click_button button
end

When(/^I click the "(.*?)" link$/) do |link|
    click_link link
end

When(/^I navigate to the Quick Booking page for the (.*?) service$/) do |service|
    click_button QUICK_BOOKING_BTN
    select_option(SL_SELECT_SERVICE, service)
    click_button NEXT_BTN
end

When(/^I set the (rental|tour|check in) date to be a valid future date$/) do |_|
    click_css(SL_CHECKIN)
    click_css(SL_CALENDAR_NEXT)
    click_css(SL_VALID_DATE)
    click_css(SL_GRAND_TOTAL)
end

When(/^I login using (valid|invalid) credentials$/) do |valid_credentials|
    if page.has_field?('Email')
        email = VALID_EMAIL
        password = VALID_PASSWORD

        if valid_credentials != "valid"
            email = "wrong@wrong.com"
            password = "wrong"
        end

        fill_in 'Email', with: email
        fill_in 'Password', with: password
        click_button 'Login'
    else
        puts "User was already in a logged in state."
    end
    expect(page).to have_button QUICK_BOOKING_BTN    
end

When(/^I set the extras to (.*?)$/) do |extras|
    if extras == "on" 
        click_css('input[id="extras_10"]')
        click_css('input[id="extras_11"]')
        click_css('input[id="extras_12"]')
    end
end

When(/^I set the room type to (.*?)$/) do |room|
    select_option(SL_SELECT_ROOM_TYPE, room)
end

When(/^I set the (car|hotel|tour) to (.*?)$/) do |item_type, value|
    select_option(SL_SELECT_ITEM, value)
end

When(/^I click the (edit|delete) button for the booking on row (.*?)$/) do |button, row|
    all_rows = page.all('tr')
    within(all_rows[row.to_f]) do
        case button
        when "edit"
            click_css(SL_EDIT)
        when "delete"
            click_css(SL_DELETE)
        end
    end
end

When(/^I accept the confirmation alert$/) do
    page.accept_alert
    find(SL_DELETE_CONFIRM)
end

When(/^I store the booking infomration for the booking on row (.*?)$/) do |row|
    stored_booking = get_booking_info(row.to_f)
    stored_id = stored_booking.id
end

Then(/^the booking management page should be displayed$/) do
    expect(page).to have_text MGMT_TEXT
end

Then(/^the edit booking page should be displayed$/) do
    expect(page).to have_text EDIT_BOOKING_TEXT
end

Then(/^the edit booking page should display the correct total price$/) do
    displayed_total = find(SL_GRAND_TOTAL).text
    expect(displayed_total).to eq("$" + stored_booking.total)
end

Then(/^the booking is successfully deleted from row (.*?)$/) do |row|
    after = get_booking_info(row).id
    puts "Previous ID: " + stored_id
    puts "After deletion ID: " + after
    expect(stored_id).not_to eq(after)
end