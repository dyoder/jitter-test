http = require "http"

module.exports = (port) ->
  store = require "./store"
  make_handler = require "./handler"
  handler = make_handler(store)
  server = http.createServer()
  server.on 'request', handler
  store.on "ready", ->
    console.log "Listening on port 1337"
    server.listen 1337
