import 'package:expense_app/screen/add_exp.dart';
import 'package:expense_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';
  @override
  void initState() {
    super.initState();
    _fetchUser();
    _fetchExpense();
  }

  void _fetchUser() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username') ?? 'user';
    });
    print('username : $username');
  }

  List expense = [];
  void _fetchExpense() async {
    final data = await ApiService().getExpense();
    print('data : $data');
    setState(() {
      expense = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = expense.fold(0, (sum, e) => sum + (e['amount'] ?? 0) as int);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KHARCHE",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,$username 👋",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00D084).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Color(0xFF1D201F), Color(0xFF00A86B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹$total',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Available balance across linked vaults',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Recent Expenses",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: expense.length,
                itemBuilder: (context, index) {
                  Map<String, IconData> categoryIcons = {
                    'food': Icons.restaurant,
                    'travel': Icons.directions_car,
                    'shopping': Icons.shopping_bag,
                    'rent': Icons.home,
                  };
                  final exp = expense[index];
                  return Dismissible(
                    key: Key(exp['_id']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) async {
                      setState(() {
                        expense.removeAt(index);
                      });
                      await ApiService().deleteExp(exp['_id']);
                    },
                    child: GestureDetector(
                      onTap: () async {
                        final result =await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddExp(
                              id: exp['_id'],
                              existingTitle: exp['title'],
                              existingAmount: exp['amount'],
                              existingDate: exp['date'] != null
                                  ? DateTime.parse(exp['date'])
                                  : null,
                            ),
                          ),
                        );
                        if (result == true) {
                          _fetchExpense();
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        color: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  categoryIcons[exp['title']] ??
                                      Icons.attach_money,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exp['title'] ?? 'No Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
                                    ),
                                    Text(
                                      (exp['date'] ?? 'No date')
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 70),
                              Text(
                                '~₹${exp['amount'] ?? 0}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExp()),
          );
          if (result == true) {
            _fetchExpense();
          }
        },
      ),
    );
  }
}
