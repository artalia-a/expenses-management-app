import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/counter_cubit.dart';
import 'package:my_app/db/database_instance.dart';
import 'package:my_app/dto/expenses.dart';
import 'package:intl/intl.dart';
import 'package:my_app/screens/routes/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get child => null;
  // Mendefinisikan variabel position1 dan position2
  Offset position1 = Offset(50, 50);
  Offset position2 = Offset(150, 50);

  DatabaseInstance? databaseInstance;
  int totalExpenses = 0;

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    getTotalExpenses();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future getTotalExpenses() async {
    int total = await databaseInstance!.totalExpenses();
    setState(() {
      totalExpenses = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Hi, Vanya',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 40),
                child: Text(
                  'Check your expenses today!',
                ),
              ),
            ],
          ),
          Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 320,
                height: 165,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 104, 33, 248),
                      Color.fromARGB(255, 211, 173, 248)
                    ])),
              ),
              Column(children: [
                Text(
                  "Total Expenses this month",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Rp. ${NumberFormat('#,##0', 'id_ID').format(totalExpenses)}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ],
          )),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 100, right: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 219, 208, 237), // Warna latar belakang kotak
                      borderRadius: BorderRadius.circular(10), // Bentuk kotak
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(228, 4, 28, 89),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/create-screen');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Add Expense'),
                ]),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 219, 208, 237), // Warna latar belakang kotak
                      borderRadius: BorderRadius.circular(10), // Bentuk kotak
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.credit_card,
                        color: Color.fromARGB(228, 8, 39, 117),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/expenses-screen');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('Expenses'),
                ]),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/news-screen');
                  },
                  child: Image.asset('assets/images/new.png'),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  'Curent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          FutureBuilder<List<ExpensesModel>>(
            future: databaseInstance?.getRecentExpenses(5),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final expenses = snapshot.data ?? [];
                return Column(
                  children: expenses.map((expense) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(id: expense.id),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: 90, // Adjusted height for accommodating date
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 236, 231, 248),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: Text(
                                    'Rp. ${NumberFormat('#,##0', 'id_ID').format(expense.total)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 121, 69, 225),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: Text(
                                  '${expense.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 121, 69, 225),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: Text(
                                  expense.createdAt != null
                                      ? DateFormat('E, dd-MM-yyyy').format(
                                          DateTime.parse(expense.createdAt!))
                                      : 'Unknown',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
