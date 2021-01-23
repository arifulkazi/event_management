# README

* Ruby and Rails version
ruby 2.7, 
Rails 6.1.1

* Database
 sqlite 3.8.7.2

* Configuration
cd ../event-management
bundle install
rails db:migrate

* Run
rails server

* API's
* 1. List all events
*    GET http://127.0.0.1:3000/api/v1/events/

* 2. Sign up for a event
*    PUT http://127.0.0.1:3000/api/v1/events/#event_id

* 3. Remove email address (user) from event
*    DELETE  http://127.0.0.1:3000/api/v1/events/#event_id/users/#user_id

* 4. See all users who sign up for an event
*    GET apihttp://127.0.0.1:3000/v1/events/#event_id/users/

