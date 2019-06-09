# WWC 2019

Prerequisites

- Ruby 2.5.5
- Rails 5.2.3
- Postgresql

This API models teams and players in the Womens World Cup 2019. 

### API endpoints
| Endpoint | Functionality |
|----------|---------------|
| GET /teams   | Fetch all teams|
| POST /teams | Create a new team|
| GET    /teams/:id | Fetch a team with a known id |
| PUT    /teams/:id | Update a known team |
| DELETE /teams/:id | Delete a team and related players |
| GET    /teams/:team_id/players | Fetch all team players |
| POST   /teams/:team_id/players | Create a new player for a team |
| GET    /teams/:team_id/players/:id | Fetch a player from a known team |
| PUT    /teams/:team_id/players/:id | Update a known player |
| DELETE /teams/:team_id/players/:id | Delete a player |


### Setup
- Clone project from Github.
- `cd` into the project directory and run `bundle`
- Run the server with `rails s`

### Testing
To run tests
> rspec

