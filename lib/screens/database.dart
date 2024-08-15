import 'package:flutter/material.dart';
import 'package:tracking_flutter/services/firestore_service.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final _dbService = DatabaseService();
  final _name = TextEditingController();
  final _age = TextEditingController();
  List<Map<String, dynamic>> _dataList = [];
  // final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: _dbService.create(),
      //       child: Text('Login'),
      //     ),
      //   ],
      // ),
      Center(
        child: ListView.builder(
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_dataList[index]['name']),
              subtitle: Text('Age: ${_dataList[index]['age']}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          // _showDialog(context);
          _dbService.create();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Coba'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(hintText: "Enter your name")
              ),
              TextField(
                controller: _age,
                decoration: InputDecoration(hintText: "Enter your age"),
                keyboardType: TextInputType.number
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (_name.text.isNotEmpty && _age.text.isNotEmpty) {
                  _dataList.add({
                    'name': _name.text,
                    'age': int.parse(_age.text),
                  });
                  _name.clear();
                  _age.clear();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
