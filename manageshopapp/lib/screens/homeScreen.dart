import 'package:flutter/material.dart';
import 'package:manageshopapp/util/constants.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:manageshopapp/screens/shutterOperationScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              _buildButton("Kepenki kapat/aç",ButtonType.CLOSE_SHUTTER),
              SizedBox(height: 20),
              _buildButton("Seçenek 2",ButtonType.OPTION_2),
              SizedBox(height: 20),
              _buildButton("Seçenek 3",ButtonType.OPTION_3),
              SizedBox(height: 20),
              _buildButton("Seçenek 4",ButtonType.OPTION_4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label,ButtonType buttonType) {
    return ElevatedButton(
      onPressed: () {
        switch (buttonType) {
          case ButtonType.CLOSE_SHUTTER:
            navigateShutterCloseScreen();
            
            break;
          default:
          print('Unknown button type : ${buttonType.name}');
        }
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
  
  void navigateShutterCloseScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ShutterOperationScreen()),
      );    
  }
}
