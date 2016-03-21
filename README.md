Readme
------

Some examples on how to use ampq-as-promised rpc mechanism.


**Notes**

`consumer` creates the consuming rpc queue. If we launch the producer
but we have never launched the consumer before there will be no queue
for messages to be queued in, so all messages will be lost.

When timeout comes, all messages are discarded
