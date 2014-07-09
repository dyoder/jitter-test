{EventChannel} = require "mutual"

# TODO: Make the adapter configurable
{Adapter} = (require "pirate").Redis

module.exports = do ->

  store = new Adapter {events: new EventChannel}

  fn = (context, action) ->
    context.request.on "ready", ->
      store.collection(context.collection)
      .on "success", (collection) ->
        action(collection)
        .on "success", context.success
        .on "error", context.error
      .on "error", context.error

  fn.on = -> store.events.on arguments...
  fn
