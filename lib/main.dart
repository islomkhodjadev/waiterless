import 'package:flutter/material.dart';
import 'package:waiterless/screens/cart_screen.dart';
import 'package:waiterless/screens/home_screen.dart';
import 'package:waiterless/screens/profile_screen.dart';
import 'package:waiterless/screens/register_screen.dart';
import 'package:waiterless/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.greenMain,
          onPrimaryFixedVariant: AppColors.greenMain,
          secondary: AppColors.lightBlue,
          surface: AppColors.white,
          onPrimary: AppColors.white,
          onSecondary: AppColors.darkGrey,
          onSurface: AppColors.darkGrey,
          inversePrimary: AppColors.greenMain,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          bodyLarge: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: AppColors.greenMain,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.greenMain,
          textTheme: ButtonTextTheme.primary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.greenMain,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenMain,
            foregroundColor: AppColors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.greenMain),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.greenMain,
            side: const BorderSide(color: AppColors.greenMain),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/': (context) => UserInfoScreen(),

        '/home': (context) => MyHomePage(
              title: "Home",
            ),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(username: "Islomkhodja"),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    CartScreen(),
    ProfileScreen(username: "Islomkhodja"),
  ];

  void _onTap(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _page,
        onTap: _onTap,
      ),
    );
  }
}
