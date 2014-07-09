{resource} = require "shred"
{inspect} = require "util"
assert = require "assert"
amen = require "amen"

jitter = resource "http://localhost:1337{/collection}{/key}",
    get:
      method: "get"
      headers: "accept": "application/json"
      expect: 200
    put:
      method: "put"
      headers: "content-type": "application/json"
      expect: 200
    delete:
      method: "delete"
      expect: 200
    post:
      method: "post"
      headers: "content-type": "application/json"
      expect: 201


amen.describe "A Jitter server...", (context) ->

  context.test "Can create new objects with POST", (context) ->
      jitter
        collection: "people"
      .post
        name: "Dan"
        email: "dan@pandastrike.com"
      .on "success", (response) ->
        context.pass ->
          assert.equal response.headers.location?, true


  context.test "Can put and get objects", (context) ->

    jitter
      collection: "people"
      key: "dan"
    .put
      name: "Dan"
      email: "dan@pandastrike.com"
    .on "success", ->
      jitter
        collection: "people"
        key: "dan"
      .get()
      .on "ready", (person) ->
        context.pass ->
          assert.equal person.name, "Dan"
          assert.equal person.email, "dan@pandastrike.com"

        context.test "Can delete objects", (context) ->
          jitter
            collection: "people"
            key: "dan"
          .delete()
          .on "success", ->
            jitter
              collection: "people"
              key: "dan"
            .get()
            .on "error", (error) ->
              context.pass ->
                assert.equal error.response.statusCode, 404
            .on "ready", (person) ->
              context.fail new Error("Expected 404, got 200")
