# Food Prefs

This is fun project using Phoenix on a back end side and React on a front end.

## Deployment

### Client

```bash
heroku config:set REACT_APP_API_URL={server_url} -a {client_app_heroku_name}
heroku git:remote -a {client_app_heroku_name}
git subtree push --prefix client heroku master
```

### Server

```bash
heroku git:remote -a {server_app_heroku_name}
heroku config:set SECRET_KEY_BASE={result of mix phx.gen.secret} -a {server_app_heroku_name}
git subtree push --pref server heroku master
heroku run "POOL_SIZE=2 mix ecto.migrate" -a {server_app_heroku_name}
# seeds
heroku run "POOL_SIZE=2 mix run priv/repo/seeds.exs" -a {server_app_heroku_name}
```
