import 'package:flutter/material.dart';
import 'package:my_app/db/database_instance.dart';
import 'package:my_app/dto/expenses.dart';
import 'package:my_app/components/asset_image_widget.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final int? id;

  DetailScreen({required this.id});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseInstance? databaseInstance;
  ExpensesModel? expense;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      databaseInstance = DatabaseInstance();
      fetchExpenseDetails(widget.id!);
    }
  }

  Future<void> fetchExpenseDetails(int? id) async {
    if (id != null) {
      // Fetch the expense details from the database using the provided id
      expense = await databaseInstance!.getExpenseById(id);
      setState(() {});
    } else {
      // Handle the case where ID is null
      print('ID is null. Cannot fetch expense details.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text('Total Expenses'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Rp. ${NumberFormat('#,##0', 'id_ID').format(expense?.total)}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 69, 225),
                    ),
                  ),
                ),
              ],
            ),
            // Other details using the fetched expense data
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: AssetImageWidget(imagePath: 'assets/images/expenses.png'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expenses For'),
                  Text(
                    '${expense?.name ?? "Loading..."}',
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expenses Date'),
                  Text('${expense?.createdAt}')
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Financial Source'),
                  Text(
                    '${expense?.financialSource ?? "Loading..."}',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
