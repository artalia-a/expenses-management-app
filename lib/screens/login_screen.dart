import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/auth/cubit/auth_cubit.dart';
import 'package:my_app/dto/login.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/components/auth_wrapper.dart';
import 'package:my_app/screens/login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendLogin(context, AuthCubit authCubit) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(email, password);
    if (response.statusCode == 200) {
      debugPrint('Sending Success');
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage
          .write(key: tokenStoreName, value: loggedIn.accessToken);

      authCubit.login(loggedIn.accessToken);
      Navigator.pushReplacementNamed(context, '/home-screen');
      debugPrint(loggedIn.accessToken);
    } else {
      debugPrint('failed');
    }
  }

  @override

  //final authCubit = BlocProvider.of<AuthCubit>(context);
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: -40,
                          height: 400,
                          width: width,
                          child: FadeInUp(
                            duration: Duration(seconds: 1),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          )),
                      Positioned(
                          height: 400,
                          width: width + 20,
                          child: FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/background-2.png'),
                                      fit: BoxFit.fill)),
                            ),
                          ))
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(196, 135, 198, .3)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromRGBO(
                                                196, 135, 198, .3)))),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700)),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: Center(
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(196, 135, 198, 1)),
                                )))),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: MaterialButton(
                          onPressed: () {},
                          color: Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          child: Center(
                            child: TextButton(
                                onPressed: () {
                                  sendLogin(context, authCubit);
                                  // Navigator.pushNamed(context, '/home-screen');
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                )),
                            // child: Text(
                            //   "Login",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, .6)),
                                )))),
                  ],
                ),
              )
            ])));
  }
}
