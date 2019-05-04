# Shopix

Shopix is a work in progress of an e-commerce platform written in Elixir and using the Phoenix Web framework.

This is a Work In Progress and right now it should not be used in production without intensive testing.

If you want to encourage me to work on this project, you can make donations, right now in crypto-currencies.

[![Donate with Ethereum](https://en.cryptobadges.io/badge/micro/0x0C24C23Bb3a6D2f151c76ea8e9B84721cb7D4dA5)](https://en.cryptobadges.io/donate/0x0C24C23Bb3a6D2f151c76ea8e9B84721cb7D4dA5)
[![Donate with Bitcoin](https://en.cryptobadges.io/badge/micro/1HpfsUzKyvgJ65nbZJgxfAhV7hWPBpH25d)](https://en.cryptobadges.io/donate/1HpfsUzKyvgJ65nbZJgxfAhV7hWPBpH25d)

# Features

* Clean Administration UI
* Front-end theme using Bootstrap 4
* Handles products with multiple images (through Uploadcare)
* Unlimited groups and properties for products
* Unlimited translations / locales
* Braintree gateway
* Static pages
* VAT + Single Shopping cost

# Screenshots

![First screenshot](https://raw.githubusercontent.com/nicolasblanco/shopix/master/documents/screenshot1.png)
![Second screenshot](https://raw.githubusercontent.com/nicolasblanco/shopix/master/documents/screenshot2.png)
![Third screenshot](https://raw.githubusercontent.com/nicolasblanco/shopix/master/documents/screenshot3.png)
![Forth screenshot](https://raw.githubusercontent.com/nicolasblanco/shopix/master/documents/screenshot4.png)

# What's missing?

  * Lots of polishing, testing, refactoring, etc.
  * Multiple/different VAT % (?)
  * Multiple/different shipping costs
  * Multiple payment gateways
  * Multiple images providers
  * Themes engine (Liquid?)

# Installation of development server

  * Install dependencies with `mix deps.get`
  * Configure your database access by editing `config/dev.exs`
  * Create an [Uploadcare](https://uploadcare.com) account and a [Braintree Sandbox](https://sandbox.braintreegateway.com) account
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Run seeds with the first user admin account credentials:
  `ADMIN_EMAIL=admin@admin.com ADMIN_PASSWORD=abcd1234 mix run priv/repo/seeds.exs`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * Go to `http://localhost:4000/admin`, login with admin credentials
  * Go to Global configuration tab. Fill in the Uploadcare public key.
  * In the "Payment Gateway" field, add this config:
  `{"provider_config":{"public_key":"your_braintree_public_key","private_key":"your_braintree_private_key","merchant_id":"your_braintree_merchant_id","environment":"sandbox","client_token":"your_braintree_tokenized_key"}}`

## Contributions

I really welcome contributions.

Please don't forget to write tests when doing pull requests.
