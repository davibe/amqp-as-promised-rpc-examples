{ amqpc, Q, log } = require '../common'

options =
	ack: true

amqpc.serve 'myexchange', 'routing.key', options, (message, headers, del) -> Q.genrun ->
  log('< received message', message)

  yield Q.delay(500)

  answer = { result: 'ok', message: message }

  log('< answering message', answer)
  answer
