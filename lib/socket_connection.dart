import 'dart:io';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/html.dart';
import 'dart:async';
import 'package:super_app/utils/Logger.dart' as logger;

// for Web apps
class WebSocketClient {
  final String url;
  late WebSocketChannel _channel;
  Timer? _pingTimer;
  Timer? _pongTimeoutTimer;

  WebSocketClient(this.url);

  void connect() {
    _channel = HtmlWebSocketChannel.connect(url);
    _channel.stream.listen((message) {
      logger.Logger.printLogs('Received: $message');
      if (message == 'pong') {
        _resetPongTimeout();
      }
    }, onError: (error) {
      logger.Logger.printLogs('Error: $error');
    }, onDone: () {
      logger.Logger.printLogs('Connection closed');
      _cleanUpTimers();
    });
    _startPing();
  }

  void sendMessage(String message) {
    logger.Logger.printLogs('Sending message: $message');
    _channel.sink.add(message);
  }

  void _startPing() {
    _pingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      logger.Logger.printLogs('Sending ping');
      _channel.sink.add('ping');
      _startPongTimeout();
    });
  }

  void _startPongTimeout() {
    _pongTimeoutTimer?.cancel();
    _pongTimeoutTimer = Timer(const Duration(seconds: 40), () {
      logger.Logger.printLogs('Pong not received in 40 seconds. Closing connection.');
      close();
    });
  }

  void _resetPongTimeout() {
    logger.Logger.printLogs('Pong received, resetting timeout.');
    _pongTimeoutTimer?.cancel();
  }

  void close() {
    _pingTimer?.cancel();
    _pongTimeoutTimer?.cancel();
    _channel.sink.close();
  }

  void _cleanUpTimers() {
    _pingTimer?.cancel();
    _pongTimeoutTimer?.cancel();
  }
}


// for Mobile apps
class TcpClient {
  final String address;
  final int port;
  Socket? _socket;

  TcpClient(this.address, this.port);

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(address, port);
      logger.Logger.printLogs('Connected to: ${_socket!.remoteAddress.address}:${_socket!.remotePort}');
      _socket!.listen(
            (List<int> event) {
          final response = utf8.decode(event);
          logger.Logger.printLogs('Server response: $response');
        },
        onError: (error) {
          logger.Logger.printLogs('Error: $error');
          _socket!.destroy();
        },
        onDone: () {
          logger.Logger.printLogs('Server closed connection');
          _socket!.destroy();
        },
      );
    } catch (e) {
      logger.Logger.printLogs('Unable to connect: $e');
    }
  }

  void sendPing() {
    if (_socket != null) {
      logger.Logger.printLogs('Sending ping');
      _socket!.write('ping\n');
    } else {
      logger.Logger.printLogs('Socket is not connected');
    }
  }

  void close() {
    _socket?.close();
  }
}



