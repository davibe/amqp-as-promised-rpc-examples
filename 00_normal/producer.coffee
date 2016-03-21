{ amqpc, Q, log, messageGenerate } = require '../common'


Q.genrun ->

  while true
    headers = {}
    options = {} # ms
    message = messageGenerate()
    log('--')
    log('> publishing message', message)

    amqpc.rpc('myexchange', 'routing.key', message, headers, options)
    .then (response) ->
      log('< received response ', response.message)
    .catch (e) ->
      log('< received error', e)

    yield Q.delay(1000)

.catch (e) -> console.error e, e.stack.split('\n')
