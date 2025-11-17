## 1. Introduction

- Multiplayer in Godot lets you connect several players together over a network to play, chat, or interact in real time.
- Godot uses a **high-level API** to make simple multiplayer easier (you don’t need to worry about networking details).
- You can run your game as a server or as a client and exchange data between them.

---

## 2. Key Multiplayer Concepts

| Concept            | Description                            | Typical Use                         |
|--------------------|----------------------------------------|-------------------------------------|
| **Server**         | Hosts the game, keeps authoritative state. | One instance controls the game world. |
| **Client**         | Connects to the server, receives and sends data. | Each player runs a client.           |
| **Peer ID**        | Unique number for every connected computer. | Helps identify who sent/received data. |

---

## 3. Starting Multiplayer (Proof of Concept)

- Use the `ENetMultiplayerPeer` node for networking.
- Use simple code to make your game a server or have it join as a client.

### Server Example
```gdscript
var peer = ENetMultiplayerPeer.new()
peer.create_server(PORT_NUMBER, MAX_CLIENTS)
multiplayer.multiplayer_peer = peer
```

### Client Example
```gdscript
var peer = ENetMultiplayerPeer.new()
peer.create_client(SERVER_IP, PORT_NUMBER)
multiplayer.multiplayer_peer = peer
```
- Replace `PORT_NUMBER` (e.g. 7000), `MAX_CLIENTS` (e.g. 8), and `SERVER_IP` (like "127.0.0.1" for localhost).

---

## 4. Sending Data (RPCs)

- Use **Remote Procedure Calls** (`@rpc`) to run functions on other computers.
- Mark functions with `@rpc` and call them using `.rpc()` or `.rpc_id()`.

### RPC Example
```gdscript
@rpc
func announce_joined(name):
    print(name, "has joined!")
    
func _ready():
    if multiplayer.is_server():
        announce_joined.rpc("Server")
    else:
        announce_joined.rpc("A Client")
```

---

## 5. Basic Multiplayer Flow

1. Start the game as a **server** or **client**.
2. When a player connects, send a welcome message with `announce_joined.rpc()`.
3. Try simple synchronization, like sending position or score using RPCs.

---

## 6. Quick Checklist

- Use **localhost** (`127.0.0.1`) for local tests; use your machine’s IP address for LAN.
- Make sure to use the same port number for both server and clients.
- Only test simple things at first (like printing messages or moving objects) to confirm networking works.
- You need to open/forward your port in your router settings if you want people outside your network to connect.

---

## 7. Troubleshooting Tips

- If connections fail, double check IP address and port number.
- Use signals like `peer_connected` and `peer_disconnected` to track who’s online.
- Only add multiplayer if you have time for debugging and testing—bugs can be unpredictable.

---

## 8. Example: The Simplest Lobby

```gdscript
extends Node
const PORT = 7000
const MAX_CLIENTS = 8

func host_game():
    var peer = ENetMultiplayerPeer.new()
    peer.create_server(PORT, MAX_CLIENTS)
    multiplayer.multiplayer_peer = peer

func join_game(ip):
    var peer = ENetMultiplayerPeer.new()
    peer.create_client(ip, PORT)
    multiplayer.multiplayer_peer = peer

@rpc
func welcome(msg):
    print(msg)

func _ready():
    if multiplayer.is_server():
        welcome.rpc("Welcome! (Server)")
    else:
        welcome.rpc("Welcome! (Client)")
```

---

**In summary:**  
Godot’s high-level multiplayer is designed for quick tests and simple setups. You can host or join a session, use RPCs to communicate, and try simple experiments like passing messages. For a proof of concept, focus on just connecting two instances and sending a message or moving a player. If you want more, read deeper into Godot’s networking docs!
```
