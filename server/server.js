var util = require("util");
var io = require("socket.io");
var PS = require("./purs.js");

var socket;

function init() {
  socket = io.listen(8000);

  setEventHandlers();

  console.log("server started");
};

function setEventHandlers() {
  socket.sockets.on("connection", onSocketConnection);
};

function onSocketConnection(client) {
  util.log("onSocketConnection: " + client.id);
  client.on("message", onMessage);
};

function onMessage(data) {
  util.log("received: " + JSON.stringify(data.adt));
  util.log("calling purescript: " + PS.showMyAdt(data.adt));
};

init();
