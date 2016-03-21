{ amqpc, Q, messageGenerate, log } = require '../common'

before = Date.now()
generatedCount = 0
failedCount = 0

Q.genrun ->

  while true
    headers = {}
    options = {} # ms
    message = messageGenerate()

    amqpc.rpc('myexchange', 'routing.key', message, headers, options)
    .catch (e) ->
      failedCount += 1

    generatedCount += 1
    now = Date.now()
    if (now - before) > 1000
      log("generated #{generatedCount}/s failed #{failedCount}/s")
      before = now
      generatedCount = 0
      failedCount = 0

    yield Q.delay(0)

.catch (e) -> console.error e, e.stack.split('\n')
