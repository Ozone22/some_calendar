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

TODO:

- Some js validations, maybe
- Some data fixtures, maybe
- Deploy to heroku

### Additional functional - find free days between users

System can find free days(without any event) between two users. User can be selected through select box, or, searched by email. 
If user with same email exists, it will be selected automatically. Why this function? It will be helpful, if service will be socialized.
Invite friend to meet will be easier with this function. 

### ER-diagram

Database schema(schedule field in event - serialized ice_cube schedule):

![ER-diagram image](https://res.cloudinary.com/djfhtqjzs/image/upload/v1474139508/Calendar_wgohe6.png)