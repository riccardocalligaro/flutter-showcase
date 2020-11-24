const net = require("net");

const hostname = "localhost";
const port = 8000;

let currentSocket = null;

const readline = require("readline")
  .createInterface({
    input: process.stdin,
    output: process.stdout,
  })
  .on("line", (input) => {
    if (currentSocket) {
      currentSocket.write(input);
      console.log(`Data sent to client: ${input}`);
    }
  });

const server = net.createServer(async (socket) => {
  currentSocket = socket;
  socket.on("error", (err) => console.log("error", err));
  socket.on("data", (data) =>
    console.log(`Data received from client: ${data}`)
  );
  socket.on("close", (err) => {
    console.log("close", err);
    currentSocket = null;
  });
});

server.listen(port, hostname);
