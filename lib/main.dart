import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lib/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force landscape orientation for iPad 16:9 layout
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const RubySupermarketGame());
  });
}

class RubySupermarketGame extends StatelessWidget {
  const RubySupermarketGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruby Snow Supermarket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const HomeScreen(),
    );
  }
}
