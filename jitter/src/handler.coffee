Context = require "./context"
{randomKey} = require "key-forge"

module.exports = (store) ->

  methods =

    GET: (context) ->
      {collection, key} = context
      if collection?
        context.success = (data) ->
          if data?
            context.respond {data}
          else
            context.respond status: 404
        if key?
          store context, (collection) ->
            collection.get(key)
        else
          store context, (collection) ->
            collection.all()
      else
        context.error 404

    PUT: (context) ->
      {collection, key} = context
      context.success = -> context.respond()
      if collection? and key?
        store context, (collection) ->
          collection.put(key, context.data)
      else
        context.error 404 unless key?

    DELETE: (context) ->
      {collection, key} = context
      context.success = -> context.respond()
      if collection? and key?
        store context, (collection) ->
          collection.delete(key)
      else
        context.error 404

    POST: (context) ->
      {collection} = context
      if collection?
        context.success = ->
          context.respond
            status: 201
            headers:
              "location": "/#{collection}/#{key}"
        key = randomKey 16, "base64url"
        store context, (collection) ->
          collection.put(key, context.data)
      else
        context.error 404

  (request, response) ->
    console.log request.method, request.url
    methods[request.method](Context.make(request, response))
