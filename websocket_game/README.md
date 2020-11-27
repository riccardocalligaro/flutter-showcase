# Websocket Game

A simple quiz game with a chatroom.

- **Server**: NodeJS
- **Client**: Flutter

<p align="center">
  <img src="https://i.imgur.com/6qVCIp2.png" height="500px" alt="app screenshot">
   <img src="https://i.imgur.com/e5jmTi2.png" height="500px" alt="app screenshot">
</p>

# Project structure

- client (flutter client)
  - `core`
    - `game_button.dart`, button used in the application on multiple pages
    - `game_colors`, app default colors

  - `data`
    - `model`
      - `message_remote_model.dart`, message chat model
      - `player_remote_model.dart`, player model
      - `question_remote_model.dart`, game question model
    - `quiz_socket_manager`, where all the socket calls stay
  - `presentation`
    - `chat`
      - `chat_page.dart`, chatroom page
    - `home`
      - `home_page.dart`, home page where there is the question, the leaderboard and the answers
    - `start`
      - `start_page.dart`, where the users inputs the nickname to start the game
    - `navigator_page.dart`, navigator that controls the bottom app bar


- server
  - `src`
    - `app.js`, single javascript file that contains the websocket server 

# How do Websockets work?

A WebSocket is a persistent connection between a client and server. WebSockets provide a bidirectional, full-duplex communications channel that operates over HTTP through a single TCP/IP socket connection. At its core, the WebSocket protocol facilitates message passing between a client and server. This article provides an introduction to the WebSocket protocol, including what problem WebSockets solve, and an overview of how WebSockets are described at the protocol level.


# What is Socket.IO?

Socket.IO was created in 2010. It was developed to use open connections to facilitate realtime communication, still a relatively new phenomenon at the time.

Socket.IO allows bi-directional communication between client and server. Bi-directional communications are enabled when a client has Socket.IO in the browser, and a server has also integrated the Socket.IO package. While data can be sent in a number of forms, JSON is the simplest.

It consits of:
- Node.js server
- Javascript Client (in this case implemented in dart)
