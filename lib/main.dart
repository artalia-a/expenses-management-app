import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/news_screen.dart';
import 'package:my_app/screens/routes/create_screen.dart';
import 'package:my_app/screens/routes/cs_screen.dart';
import 'package:my_app/screens/routes/customer_support.dart';
import 'package:my_app/screens/routes/datas_screen.dart';
import 'package:my_app/screens/routes/edit_screen.dart';
import 'package:my_app/screens/routes/review.dart';
import 'package:my_app/screens/routes/update_screen.dart';
import 'package:my_app/screens/routes/detail_screen.dart';
import 'package:my_app/screens/expenses_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/screens/routes/edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Screen'),
      routes: {
        '/news-screen': (context) => const NewsScreen(),
        '/create-screen': (context) => const CreateScreen(),
        '/update-screen': (context) => const UpdateScreen(),
        '/expenses-screen': (context) => const ExpensesScreen(),
        '/profile-screen': (context) => const ProfileScreen(),
        '/datas-screen': (context) => const DatasScreen(),
        '/customer_support-screen': (context) => const CustomerSupport(),
        '/cs-screen': (context) => const CsScreen(),
        '/review-screen': (context) => const Review(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExpensesScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Expenses',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: _selectedIndex == 2
          ? const Color.fromRGBO(147, 99, 230, 1)
          : Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.scaffoldBackgroundColor,
        buttonBackgroundColor: const Color.fromRGBO(147, 99, 230, 1),
        color: const Color.fromRGBO(147, 99, 230, 1),
        items: [
          Icon(
            Icons.home,
            size: 30.0,
            color: _selectedIndex == 0 ? Colors.white : Constants.activeMenu,
          ),
          Icon(
            Icons.money,
            size: 30.0,
            color: _selectedIndex == 1 ? Colors.white : Constants.activeMenu,
          ),
          Icon(
            Icons.person,
            size: 30.0,
            color: _selectedIndex == 2 ? Colors.white : Constants.activeMenu,
          ),
        ],
        onTap: (index) {
          setState(() {
            _onItemTapped(index);
          });
        },
      ),
      drawer: Container(
        padding: const EdgeInsets.only(top: 40.0),
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 121, 69, 225),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: Text(
                  'Expenses Record',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home-screen');
                },
              ),
              ListTile(
                title: Text('Expenses (CRUD)',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/expenses-screen');
                },
              ),
              ListTile(
                title: Text('Add Expenses (CRUD)',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/create-screen');
                },
              ),
              ListTile(
                title: Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile-screen');
                },
              ),
              ListTile(
                title:
                    Text('Latihan API', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/news-screen');
                },
              ),
              ListTile(
                title: Text('Datas', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/datas-screen');
                },
              ),
              ListTile(
                title: Text('Customer Support',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/customer_support-screen');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
