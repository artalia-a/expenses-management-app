import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_app/dto/cs.dart';
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/screens/routes/review.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.CsEdit})
      : super(key: key); //required.CsEdit
  final Cs CsEdit;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  String _title = "";

  File? galleryFile;
  final picker = ImagePicker();

  final _nimController = TextEditingController();
  String _NIM = '';

  final _descriptionController = TextEditingController();
  String _description = "";

  final _ratingController = TextEditingController();
  int _rating = 0;

  String? _selectedOption;

  _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        galleryFile = File(pickedFile!.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.CsEdit.titleIssues;
    _descriptionController.text = widget.CsEdit.descriptionIssues;
    _ratingController.text = widget.CsEdit.rating.toString();
  }

  void dispose() {
    _titleController.dispose();
    _nimController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
    debugPrint(_NIM);
    debugPrint(_description);
  }

//fungsi untuk mengedit data
  Future<void> _editDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return;
    }
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Endpoints.cs}/${widget.CsEdit.idCustomerService}')); //CsEdit
    request.fields['title_issues'] = _titleController.text;
    request.fields['nim'] = _nimController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['rating'] = _ratingController.text.toString();

    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      if (response.statusCode == 200) {
        debugPrint('Data and image posted successfully!');
        saveData();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Review()));
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 48, 184),
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Your Response Here",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Your feedback shapes our future improvements, Help us tailor our services to your needs.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Decision Selected:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    value: _selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue ?? '';
                                      });
                                    },
                                    items: <String>[
                                      'IT',
                                      'Billing',
                                      'Help Center'
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Priority:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: _selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue ?? '';
                                      });
                                    },
                                    items: <String>['Hight', 'Medium', 'Low']
                                        .map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: TextField(
                                controller: _nimController,
                                decoration: const InputDecoration(
                                  hintText: "Your ID (NIM)",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _NIM = value;
                                  });
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context: context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                width: double.infinity,
                                height: 150,
                                child: galleryFile == null
                                    ? Center(
                                        child: Text(
                                          'Pick your Image here',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: const Color.fromARGB(
                                                255, 124, 122, 122),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Image.file(galleryFile!),
                                      ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  hintText: "Spotlighting",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _title = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  hintText: "Description",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _description = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _ratingController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "Rating",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  setState(() {
                                    _rating = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 30)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      //tombol untuk menyimpan perubahan data
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 116, 48, 184),
        onPressed: () {
          _editDataWithImage(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
