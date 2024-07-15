import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:super_app/my_const.dart';

class SocketService {
  late IO.Socket socket;

  void connect() {
    // Configure the socket connection
    socket = IO.io(socketBaseUrl, <String, dynamic>{
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
      //print('Message received: $data');
    });

    // Handle incoming messages
   /* socket.on('market_feed', (data) {
      //print('Message received market_feed: $data');
    });*/

    // Handle incoming messages
   /* socket.on('order_status', (data) {
      //print('Message received market_feed: $data');
    });*/

    // Handle disconnection event
    socket.on('disconnect', (_) {
      print('Disconnected from the server');
    });
  }

  void sendMessage(String message) {
    socket.emit('message', message);
  }
}
