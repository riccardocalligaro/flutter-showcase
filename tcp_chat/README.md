# TCP Chat

- **Server**: NodeJS
- **Client**: Flutter

<p align="center">
  <img src="https://i.imgur.com/dGXbLUk.png" height="500px" alt="app screenshot">
   <img src="https://i.imgur.com/dd4fZI0.png" height="500px" alt="app screenshot">
</p>


## Table of contents

- [What is a socket?](#what-is-a-socket?)
- [How it works?](#how-it-works?)
- [Libraries?](#libraries)

## What is a socket? 

A network socket is a software structure within a network node of a computer network that serves as an endpoint for sending and receiving data across the network. The structure and properties of a socket are defined by an application programming interface (API) for the networking architecture. Sockets are created only during the lifetime of a process of an application running in the node.

Because of the standardization of the TCP/IP protocols in the development of the Internet, the term network socket is most commonly used in the context of the Internet Protocol Suite, and is therefore often also referred to as Internet socket. In this context, a socket is externally identified to other hosts by its socket address, which is the triad of transport protocol, IP address, and port number.

## How it works

A client socket does not listen for incoming connections, it initiates an outgoing connection to the server. The server socket listens for incoming connections.

A server creates a socket, binds the socket to an IP address and port number (for TCP and UDP), and then listens for incoming connections. When a client connects to the server, a new socket is created for communication with the client (TCP only). A polling mechanism is used to determine if any activity has occurred on any of the open sockets.


## Libraries

- Flutter BloC for state mangement
- Bubble for simple and cool chat message effect