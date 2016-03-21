{ amqpc, Q, log, messageGenerate } = require '../common'

key = 0

Q.genrun ->

  while true
    headers = {}
    options = {} # ms
    message = messageGenerate()
    log('--')

    key = (key + 1) % 2
    routing = "routing.#{key}"

    log('> publishing message', message, routing)
    amqpc.rpc('myexchange', routing, message, headers, options)
    .then (response) ->
      log('< received response ', response.message)
    .catch (e) ->
      log('< received error', e)

    yield Q.delay(1500)

.catch (e) -> console.error e, e.stack.split('\n')
