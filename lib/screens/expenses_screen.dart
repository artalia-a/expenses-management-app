import 'package:flutter/material.dart';
import 'package:my_app/db/database_instance.dart';
import 'package:my_app/dto/expenses.dart';
import 'package:intl/intl.dart';
import 'package:my_app/screens/routes/detail_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DatabaseInstance? databaseInstance;

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your Activity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Take Control and Monitor Your Expenses!',
                  )
                ],
              ),
            ),
            FutureBuilder<List<ExpensesModel>>(
              future: databaseInstance?.getAll(),
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
                              builder: (context) =>
                                  DetailScreen(id: expense.id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            height:
                                90, // Adjusted height for accommodating date
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
                                  ),
                                ),
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
      ),
    );
  }
}
