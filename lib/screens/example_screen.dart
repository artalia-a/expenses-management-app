// ignore_for_file: library_private_types_in_public_api
//import 'dart:math';

import 'package:flutter/material.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _count = 0;
  final String imageUrl = 'https://picsum.photos/250?image=9';

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
    }
  }

  void _square() {
    //funsi untuk perpangkatan (mengalikan dengan dirinya sendiri)
    if (_count >= 2) {
      setState(() {
        _count = _count * _count;
      });
    }
  }

  void _back() {
    if (_count > 0) {
      setState(() {
        _count % 2 == 0;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(onPressed: _decrement, icon: const Icon(Icons.remove)),
        Text('Count: $_count'),
        IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
        IconButton(onPressed: _square, icon: const Icon(Icons.close)),
        IconButton(onPressed: _back, icon: const Icon(Icons.alarm)),
        Text(_count % 2 == 0 ? 'Genap' : 'Ganjil'),
      ]),
    );
  }
}

/*
2.4 = floor (2.4) = 2 membulatkan kebawah
      ceil (2.4) = 3 membulatkan keatas

  we can use ~/ untuk angka angka
 */
