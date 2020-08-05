var mqtt = require('mqtt')
var client  = mqtt.connect('mqtt://172.16.1.1', {port: 1999})

client.on('connect', function () {
  client.subscribe('presence', function (err) {
    if (!err) {
	  var times = process.argv[2];
	  for(var i=0; i < times; i++){
		client.publish('test', 'test1')
	  }
	  client.end()
    }
  })
})

client.on('message', function (topic, message) {
  // message is Buffer
  console.log(message.toString())
  client.end()
})