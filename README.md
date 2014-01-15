# Bank application

## ...

When a user is generated, the user's account is generated with an initial balance of 100 (euro?).

Users can log into the application in the browser. On the account page they can view their balance. Mind that (for now) any account page is visible for a logged in user.

## Howto

You can add a new user in the Rails console:

    $ rails c
    Loading development environment (Rails 4.0.2)
    2.1.0p0 :001 > user = User.create!(name: 'name', email: 'name@domain.nl', password: 'blahblah', password_confirmation: 'blahblah')

You can query a user's balance in the Rails console:

    $ rails c
    Loading development environment (Rails 4.0.2)
    2.1.0p0 :001 > user.account.balance
