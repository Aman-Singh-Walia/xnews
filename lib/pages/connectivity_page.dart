import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key}) : super(key: key);

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Image(
                width: 200,
                height: 200,
                image: AssetImage('assets/no_connection.png')),
          ),
          const Text(
            'You are offline',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          const Text(
            'Please connect to internet',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    'Close App',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
