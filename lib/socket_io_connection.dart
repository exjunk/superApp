import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    // Configure the socket connection
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the server
    socket.connect();

    // Handle connection event
    socket.on('connect', (_) {
      print('Connected to the server');
    });

    // Handle incoming messages
    socket.on('message', (data) {
      print('Message received: $data');
    });

    // Handle disconnection event
    socket.on('disconnect', (_) {
      print('Disconnected from the server');
    });
  }

  void sendMessage(String message) {
    socket.emit('message', message);
  }
}
