import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _pressedButton = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home-background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("Kepenki kapat/aç"),
              SizedBox(height: 20),
              _buildButton("Seçenek 2"),
              SizedBox(height: 20),
              _buildButton("Seçenek 3"),
              SizedBox(height: 20),
              _buildButton("Seçenek 4"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _pressedButton = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
