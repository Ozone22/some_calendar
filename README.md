## Calendar

Second test project for FlatStack

Now Finished:

- User registration\authorization
- User edit\update
- Event create\update\destroy - through ajax and jquery
- Some policy for events routing(correct_user, etc.)
- Event recurring for days
- Event recurring for weeks
- Event recurring for months
- Event recurring for years
- Events and users covered with Rspec tests
- Additional functional
- Data populated(using Factory gem)

TODO:

- Some js validations, maybe
- Deploy to heroku

### Additional functional - find free days between users

System can find free days(without any event) between two users. User can be selected through select box, or, searched by email. 
If user with same email exists, it will be selected automatically. Why this function? It will be helpful, if service will be socialized.
Invite friend to meet will be easier with this function. 

### Used

- SimpleCalendar gem - for calendar view(show events on the calendar)
- IceCube gem - for schedule organization
- Squeel gem - decorate database queries
- Bootstrap and font-awesome support gems
- Faker gem - for original populated data
- Figaro gem - hide sensitive data to Environment variables

### ER-diagram

Database schema(schedule field in event - serialized ice_cube schedule):

![ER-diagram image](https://res.cloudinary.com/djfhtqjzs/image/upload/v1474139508/Calendar_wgohe6.png)