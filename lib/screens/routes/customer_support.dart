import 'package:flutter/material.dart';
import 'package:my_app/components/asset_image_widget.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  _CustomerSupportState createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: null,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Our Support Team',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Is Ready to Assist You!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: AssetImageWidget(
                imagePath: 'assets/images/helpdesk.png',
                height: 300,
                width: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Our dedicated Support Team is available 24/7 to provide personalized assistance for your questions, challenges, and expert guidance. We're here whenever you need us, ensuring your needs are met with care.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Membuat jarak di antara chip menggunakan MainAxisAlignment.spaceBetween
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/cs-screen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 178, 132, 225),
                    ),
                    child: const Text(
                      'Get Started',
                      style:
                          TextStyle(color: Color.fromARGB(240, 250, 247, 247)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/review-screen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 178, 132, 225),
                    ),
                    child: const Text(
                      'Show Review',
                      style:
                          TextStyle(color: Color.fromARGB(240, 250, 247, 247)),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
