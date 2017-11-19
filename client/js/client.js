var socket = io.connect("http://localhost:8000");

var adt = PS.Main.encodeMyAdt(new PS.Main.T1(42));
var data = { adt: adt };

console.log("sending: " + JSON.stringify(data));
//console.log("sending: " + PS.Main.showMyAdt(data.adt));

socket.emit("message", data);
