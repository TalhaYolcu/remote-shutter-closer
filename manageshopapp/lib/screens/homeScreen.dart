import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _buildButtonGrid(),),
    );
  }
  
  Widget _buildButtonGrid() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        4,
        (index) => _buildButton(index + 1),
      ),
    );
  }
   Widget _buildButton(int number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Add functionality for button press
          print('Button $number pressed');
        },
        child: Text('$number'),
      ),
    );
  }
}