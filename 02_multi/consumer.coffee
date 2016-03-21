{ amqpc, Q, log } = require '../common'

options =
	ack: true

amqpc.serve 'myexchange', 'routing.#', options, (message, headers, del) -> Q.genrun ->
  log('< received message', message)

  yield Q.delay(1000)

  answer = { result: 'ok', message: message }

  log('< answering message', answer)
  answer
