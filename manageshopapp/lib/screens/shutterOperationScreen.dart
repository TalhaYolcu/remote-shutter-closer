import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thread/thread.dart';

class ShutterOperationScreen extends StatefulWidget {
  const ShutterOperationScreen({Key? key});

  @override
  State<ShutterOperationScreen> createState() => _ShutterOperationScreenState();
}

class _ShutterOperationScreenState extends State<ShutterOperationScreen> {
  bool _serverConnected = true;
  bool _buttonEnabled = false;
  late http.Client _client;
  late Thread serverListenerThread;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    _connectToServer();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  Future<void> _connectToServer() async {
    try {
      // Read config.json from assets
      String configJson = await DefaultAssetBundle.of(context).loadString('assets/config.json');
      Map<String, dynamic> config = json.decode(configJson);

      // Extract IP and port from config
      String ip = config['ip'];
      int port = config['port'];

      if (ip.isEmpty || port == 0) {
        _showToast("Invalid configurations found in config.json.");
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ip', ip);
      prefs.setInt('port', port);

      // Attempt server connection
      try {
        print('Connecting to  $ip : $port ...');
        final response = await _client.get(Uri.parse('http://$ip:$port')).timeout(Duration(seconds: 5));
        if (response.statusCode == 200) {
          setState(() {
            _serverConnected = true;
            _buttonEnabled = true;
          });
          // Listen to server after initial successful connection
          _listenToServer(ip, port);
        }
        else {
          if(_serverConnected) {
            _showToast("Failed to connect to the server.");
          }
          setState(() {
            _serverConnected = false;
            _buttonEnabled = false;
          });
        }
      }
      catch (e) {
          if(_serverConnected) {
            _showToast("Failed to connect to the server.");
          }
          setState(() {
            _serverConnected = false;
            _buttonEnabled = false;
          });
      }
    }
    catch (e) {
      _showToast("Failed to read configurations from config.json.");
    }
  }

  void _listenToServer(String ip, int port) async {
    Timer.periodic(Duration(seconds: 5), (Timer t) async {
      // Perform the GET request
      try {
        final response = await http.get(Uri.parse('http://$ip:$port'))
            .timeout(Duration(seconds: 2));
        // Handle the response here
        print('Response: ${response.statusCode}');
        if (response.statusCode == 200) {
          setState(() {
            _serverConnected = true;
            _buttonEnabled = true;
          });
          // Listen to server after initial successful connection
          _listenToServer(ip, port);
        } else {
          if(_serverConnected) {
            _showToast("Failed to connect to the server.");
          }
          setState(() {
            _serverConnected = false;
            _buttonEnabled = false;
          });
        }        
      }
      catch (e) {
        // Handle any errors that occur during the request
        print('Error: $e');
          if(_serverConnected) {
            _showToast("Failed to connect to the server.");
          }
          setState(() {
            _serverConnected = false;
            _buttonEnabled = false;
          });       
      }
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _backButtonPressed() {
    _client.close();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shutter Operation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _backButtonPressed,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _buttonEnabled
              ? () {
                  // Implement button functionality here
                }
              : null,
          child: Text('Kepenki aç / kapa'),
        ),
      ),
    );
  }
}
