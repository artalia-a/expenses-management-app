import 'package:flutter/material.dart';
import 'package:my_app/components/asset_image_widget.dart';
import 'package:my_app/db/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController totalController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController financialSourceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Add New Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const AssetImageWidget(
            imagePath: 'assets/images/create.png',
            width: 180,
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total'),
                TextField(controller: totalController),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expenses name'),
                TextField(controller: nameController),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Financial Source'),
                TextField(
                  controller: financialSourceController,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (databaseInstance != null) {
                int idInsert = await databaseInstance!.insert({
                  'total': totalController.text,
                  'name': nameController.text,
                  'financialSource': financialSourceController.text,
                  'created_at': DateTime.now().toString(),
                  'updated_at': DateTime.now().toString(),
                });
                print("New data added with ID : " + idInsert.toString());
                Navigator.pop(context);
              } else {
                print("Database instance is null!");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 178, 132, 225),
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Color.fromARGB(240, 250, 247, 247)),
            ),
          )
        ],
      )),
    );
  }
}
