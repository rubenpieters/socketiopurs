var socket = io.connect("http://localhost:8000");

var adt = new PS.Main.T1(42);
var data = { adt: adt };

console.log("sending: " + JSON.stringify(data));

socket.emit("message", data);
