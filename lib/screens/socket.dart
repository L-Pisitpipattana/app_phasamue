import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();

    socket = IO.io('http://localhost:5000');
    socket.onConnect((_) {
      print('connect');
      socket.emit('message', 'test');
    });
    print("connection");
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
