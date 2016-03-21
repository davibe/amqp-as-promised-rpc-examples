Q = require 'q-extended'
amqp = require('amqp-as-promised')
log = console.log.bind(console)

configuration =
  connection:
    url: "amqp://localhost:5672//"
  rpc:
    timeout: 10000 # ms
  logLevel: 'DEBUG'

amqpc = amqp(configuration)

messageGenerate = do (seed = 0) -> ->
  seed += 1
  { id: seed }

# graceful shutdown

graceful = ->
  log.info 'Shutting down'
  amqpc.shutdown().then ->
    process.exit 0

process.on 'SIGINT', graceful
process.on 'SIGTERM', graceful

module.exports = { Q, amqp, amqpc, configuration, log, messageGenerate }
