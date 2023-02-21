import 'package:flutter/material.dart';
import 'package:meat_gradation_app/screens/main_screen.dart';
import 'package:meat_gradation_app/screens/result_screen.dart';

var route;

void main() {
  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();
  route = MainScreen.idScreen;
  runApp(const MyApp());
}

// Class for the MyApp
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: route,
        // Routes for the app
        routes: {
          MainScreen.idScreen: (context) => const MainScreen(),
        },
      ),
    );
  }
}
