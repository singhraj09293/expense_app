import 'package:flutter/material.dart';

class AddExp extends StatefulWidget {
  const AddExp({super.key});

  @override
  State<AddExp> createState() => _AddExpState();
}

class _AddExpState extends State<AddExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D201F),
      appBar: AppBar(
        title: Text(
          'ADD EXPENSE',
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xff121815),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
