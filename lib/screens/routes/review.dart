import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/bottom_up_transition.dart';
import 'package:my_app/dto/cs.dart'; // Menggunakan DTO Cs yang baru
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/screens/routes/cs_screen.dart';
import 'package:my_app/screens/routes/edit_screen.dart';
import 'package:my_app/screens/routes/form_screen.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:my_app/dto/cs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/services/data_service.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  Future<List<Cs>>? _cs;

  //fungsi delete
  static Future<void> deleteCutomerService(int idCustomerService) async {
    final url = Uri.parse('${Endpoints.cs}/$idCustomerService');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  @override

  //The code fetches customer service data from a data service that may operate asynchronously or indirectly.
  void initState() {
    super.initState();
    _cs = DataService.fetchCustomerService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
      body: FutureBuilder<List<Cs>>(
        // Menggunakan FutureBuilder dengan tipe Cs
        future: _cs, // Menggunakan _cs yang sesuai dengan DTO Cs
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: item.imageUrl != null
                      ? Row(
                          children: [
                            Image.network(
                              fit: BoxFit.fitWidth,
                              width: 350,
                              // Menggunakan item.imageUrl dari DTO Cs
                              Uri.parse(
                                      '${Endpoints.baseURLLive}/public/${item.imageUrl}')
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        )
                      : null,
                  subtitle: Column(children: [
                    Text(
                      'NIM : ${item.nim}', // Menggunakan item.nim dari DTO Cs
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 36, 31, 31),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Title Issue : ${item.titleIssues}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 36, 31, 31),
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    Text(
                      'Description : ${item.descriptionIssues}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 36, 31, 31),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    //fungsi untuk menampilkan rating
                    RatingBar(
                      minRating: 1,
                      maxRating: 5,
                      ignoreGestures: true,
                      allowHalfRating: false,
                      initialRating: item.rating.toDouble(),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),
                      onRatingUpdate: (double ratings) {},
                    ),
                    // Tambahkan tombol edit dan delete sesuai kebutuhan Anda di sini
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //for update
                        IconButton(
                            icon: Icon(Icons.update),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                          CsEdit:
                                              item))); //menuju ke screen update atau edit
                            }),

                        //for delete
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete Data"),
                                  content: Text(
                                      "Are you sure you want to delete this data?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Delete"),
                                      onPressed: () async {
                                        try {
                                          await deleteCutomerService(
                                              data[index].idCustomerService);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Data deleted successfully"),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text("Failed to delete data"),
                                            ),
                                          );
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                  ]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 116, 48, 184),
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(context, BottomUpRoute(page: const CsScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
