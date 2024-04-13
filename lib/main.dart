import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/news_screen.dart';
import 'package:my_app/screens/routes/create_screen.dart';
import 'package:my_app/screens/routes/update_screen.dart';
import 'package:my_app/screens/routes/detail_screen.dart';
import 'package:my_app/screens/expenses_screen.dart';
import 'package:my_app/screens/profile_screen.dart';

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
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
