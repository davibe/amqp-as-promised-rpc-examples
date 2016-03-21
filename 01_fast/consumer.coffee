{ amqpc, Q, log } = require '../common'


options =
  ack: true

before = Date.now()
count = 0

amqpc.serve 'myexchange', 'routing.key', options, (message, headers, del) -> Q.genrun ->

  count += 1
  now = Date.now()
  if (now - before) > 1000
    log("processed #{count}/s")
    before = now
    count = 0

  answer
