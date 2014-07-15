{include} = require "fairmont"

module.exports = do ->
  parse_url = (url) ->
    {pathname, query} = require('url').parse(url, true)
    [collection, key, rest...] = pathname[1..].split('/')
    if (rest.length > 0) or (query.key? and key?) or !collection?
      {}
    else
      query.collection = collection
      query.key ?= key
      query

  read_body = (context) ->
    {request} = context
    body = ""
    request.on "data", (data) -> body += data
    request.on "end", ->
      context.body = body
      context.data = if request.headers["content-type"] is "application/json"
        JSON.parse(body)
      else
        body
      request.emit "ready"
    context

  class Context

    @make: (request, response) -> new Context(request, response)

    constructor: (@request, @response) ->
      include @, parse_url(@request.url)
      read_body @

    respond: ({status, headers, data}={}) ->
      {request, response} = @
      status ?= 200
      headers ?= {}
      if data?
        body = if request.headers.accept is "application/json"
          JSON.stringify data
        else
          data.toString()
        include headers,
          'content-length': body.length
          'content-type': 'application/json'
        response.writeHead status, headers
        response.end body
      else
        response.writeHead status, headers
        response.end()

    # default success handler
    success: (data=null) => @respond {data}

    error: (status) =>
      @response.writeHead status, {}
      @response.end()
