import 'package:flutter/material.dart';


class Authentication extends StatelessWidget {
  final String text;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;
  final VoidCallback onButton3Pressed;

  const Authentication({
    super.key,
    required this.text,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.onButton3Pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Authenticate With Brokers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text widget
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button 1
                ElevatedButton(
                  onPressed: onButton1Pressed,
                  child:  const Text('Login with Upstox'),
                ),
                const SizedBox(width: 20),
                // Button 2
                ElevatedButton(
                  onPressed: onButton2Pressed,
                  child: const Text('Login with Dhan'),
                ),
                const SizedBox(width: 20),
                // Button 3
                ElevatedButton(
                  onPressed: onButton3Pressed,
                  child: const Text('Login with Zerodha'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

