# Bank application

## Howto

You can add a new user in the Rails console:

    $ rails c
    Loading development environment (Rails 4.0.2)
    2.1.0p0 :001 > user = User.create!(name: 'name', email: 'name@domain.nl', password: 'blahblah', password_confirmation: 'blahblah')

You can query a user's balance in the Rails app in your browser or in the Rails console:

    $ rails c
    Loading development environment (Rails 4.0.2)
    2.1.0p0 :001 > user.account.balance


When a user is generated, the user's account is generated with an initial balance of 100 (euro?).

Users can log into the application in the browser. On the account page they can view their balance and the bank statements (a log, so you can find out the history). There is a transfer page which can be used to make a transfer. Just fill in the username and the amount.

Error messages are not very graceful yet. :-)
