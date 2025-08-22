# PASSWORD MANAGER

## Simple web service which provide functionality to store and recover encrypted passwords
### all passwords in the system are encrypted with individual PGP keys created during registration step

List of available functions:

1. Create new user account
2. Login to account with credentials provided on registration
3. Verify session
4. Create/List/Get/Update/Delete password records for resources using JWT session token
5. Logout from active session

Note: Service made for test purposes only and need a lot of improvements

## Setup

The easiest way to get the application up and running is run it in the docker.
You can spin both services(users and manager) services up using the following command:

Note: for the testing purposes data for Keycloak is already in the dump so you don't need to spin up new REALM and 
service client, but if you want to - pls do. 
`docker-compose up -d --build`
* Wait until all services up and running make sure that all 5 containers(`users`, `manager`, `users_db`, `manager_db`, `users_keycloak`) are up and running. If not, run it

## Basic usage

Please use this commands to perform basic communication with system:

* Run: `curl --location 'http://localhost:8081/service/v1/users' \
  --header 'Content-Type: application/json' \
  --data-raw '{
  "username":"i.ivanov",
  "email":"i.ivanov@gmail.com",
  "first_name": "Ivan",
  "last_name": "Ivanov",
  "password": "Qwerty!23"
  }'`
* Run: `curl --location 'http://localhost:8081/service/v1/users/login' \
  --header 'Content-Type: application/json' \
  --data '{
  "username": "i.ivanov",
  "password": "Qwerty!23"
  }'`
* Use `access_token` obtained from previous response to perform following operations:
* Run: `curl --location 'http://localhost:8082/service/v1/records' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: ••••••' \
  --data '{
  "name": "gmail.com", "value": "ololo123"
  }'` to create a new record in the system
* Run: `curl --location --request GET 'http://localhost:8082/service/v1/records' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer ••••••'` to list all records created for current user

* Run: `curl --location --request GET 'http://localhost:8082/service/v1/records/{RECORD_ID}' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: ••••••'` to get specific record information decrypted

### Tests ###
Testing cover is very poor due to the time limits

### Future improvements ###
* Add more tests
* Expand users service to use more possibilites provided by Keycloak including verbose Registration/Authorization flows
* Use Vault to store secrets
* Improve errors handling
