import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database_helper.dart';
import 'providers/cocktail_provider.dart';
import 'pages/welcome_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => DatabaseHelper()),
        ChangeNotifierProvider(create: (context) => CocktailProvider()),
      ],
      child: MaterialApp(
        title: 'User Registration App',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark().copyWith(
            primary: Colors.blue,
            secondary: Colors.blueAccent,
          ),
          scaffoldBackgroundColor: Color(0xFF121212),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/welcome': (context) => WelcomePage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
