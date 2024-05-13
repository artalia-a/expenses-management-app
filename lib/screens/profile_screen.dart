//import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:my_app/components/asset_image_widget.dart';
// import 'package:my_app/screens/routes/SecondScreen/second_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void goToAnotherRoute(context, screen) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => screen),
    // );
    // Navigator.pushNamed(context, '/second-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // appBar: AppBar(
      //   title: const Text('Profile'),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Vanya Glamora",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Container(
              width: 500,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/jiwon.jpeg'),
                    ),
                  ),
                   const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Username'), Text('Vanya')],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Email'), Text('Vanya.ga@gmail.com')],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Phone'), Text('0987654321')],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Password'), Text('*********')],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 178, 132, 225),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(color: Color.fromARGB(240, 250, 247, 247)),
            ),
          )
                ],
              ),
            ),
          )),
          // const Padding(
          //   padding: EdgeInsets.only(left: 10, top: 10, bottom: 50),
          //   child: CircleAvatar(
          //     radius: 70,
          //     backgroundImage: AssetImage('assets/images/jiwon.jpeg'),
          //   ),
          // ),
         
        ],
      ),
    );
  }
}
