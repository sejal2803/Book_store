# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Need to take a git clone 
  ``

* Go to project directory

* Run the command
  `bundle install`

* Create the database
  `rake db:create`

* Run the migration and seed for creating the table and there data
  `rake db:migrate db:seed`

* Run the rails server
  `rails server`

* `bookstore.postman_collection.json` this is the collection for all the API's. You just need to import it
Note: - `bookstore.postman_collection.json` present in db directory
      - Firstly you need to hit the `create new admin account` api.
      - After that need to hit the `admin login` api. So you will get the token, 
      - Then you just pass this token in the header section(Key = Authorization) of all the API's except the `get` request.

* Run all the test cases 
  `rspec`

* If you want to check the coverage of the test cases
  `google-chrome coverage/index.html`
