# README

## Notes

- I REALLY ran with two points from the prompt: "No DB necessary" and "Surprise Us"
- I thought the excercise was a little vanilla, so I tried to showcase my Ruby skills by focusing on the data creation and in memory persistence 
- I did have fun with this though and as a result spent more time on it than I should have...

## Setup

- Pull down repo
- Run `bundle install`
- Run `bundle exec rails server` to start server

## Usage

- Exercise the API via Postman or CURL
- After starting server locally, it should be running at localhost:3000, use this base URL for all following requests
- Available requests:
  - GET    /v1/journals
  - POST   /v1/journals/
  - GET    /v1/journals/:id
  - PUT    /v1/journals/:id
  - DELETE /v1/journals/:id
  - GET    /v1/journals/:journal-id/entries
  - GET    /v1/journals/:journal-id/entries/:id

## QA Steps

### TEST GET REQUESTS

- Make first request: GET /v1/journals
  - You should see all journals from seed data (4)
- Copy an ID from the above response and make second request: GET /v1/journals/:id/entries
  - You should see all entries from seed data (10 per journal)
- Copy an ID from the above response and make third request: GET /v1/journals/:journal-id/entries/:id

### TEST JOURNAL CRUD REQUESTS

- Successfully create a new Journal with this request: POST /v1/journals with parameters: { name: <name> }
  - curl --location --request POST 'localhost:3000/v1/journals?name=Bobby%20Tables%27%20Journal'
  - Get all Journals again to see it was saved (it will be gone after a server restart though)

- Try to create a new Journal and receive an error message with this request (missing name parameter)
  - curl --location --request POST 'localhost:3000/v1/journals'

- Update a Journal's name (You will need to get the Journal ID from a response since IDs are randomly generated UUIDs)
  - curl --location --request PUT 'localhost:3000/v1/journals/b130ab52-e1e9-4b2d-a3dd-d48e5011da5c?name=YOLO'

- Delete a Journal
  - curl --location --request DELETE 'localhost:3000/v1/journals/b130ab52-e1e9-4b2d-a3dd-d48e5011da5c'

## Steps to Legit MVP (Focusing on BE API only)

- Set up DB connection to persist data
- Make models inherit from ApplicationRecord to leverage ActiveRecord ORM (Don't reinvent the wheel! Unless you're just messing around...)
- Set up AR associations
- Create a User or Author model - some entity that "owns" journals and can be used for authentication and filtering (/v1/journals should only return Journals that belong to a User/Author versus ALL Journals as it currently does)
- Implement API authentication, perhaps with JWT Tokens
- Finish CRUD actions for EntriesController
- Create serializers if JSON responses need to be more complex or dynamic. For example, do we want to return some associated Journal data from the Entries endpoint? Do we want some metadata about Entries (how many per journal) from the Journals endpoint? Do we want to provide options for extra info like this on a per request basis via some param?
- Add error handling and helpful JSON error messages to all endpoints that could fail/raise an error
- Meet with stakeholders and explain functionality, double check if anything else is needed


