# Jitter

Jitter is a just-in-time HTTP server for simple dictionary resources.

In `server.coffee`:

```coffee-script
server = require "jitter"
server 1337
```

Now you can use it:

```coffee-script
curl -XPUT localhost:1337/weather/santa-monica -d'70 degrees and sunny'
curl localhost:1337/weather/santa-monica
70 degrees and sunny
```

## Status

Jitter is still under development.

## Interface

* `GET {/collection}` - Get all the items in the collection
* `GET {/collection}{/key}` - Get the item in the collection with the given key
* `PUT {/collection}{/key}` - Update the item in the collection with the given key
* `DELETE {/collection}{/key}` - Delete the item in the collection with the given key
* `POST {/collection}` - Create an item in the collection using a random key

## Installation

1. Clone this repo
2. `npm install`

If you want to run the tests, you'll also have to clone the Shred and Amen repos and `npm link` to them.
