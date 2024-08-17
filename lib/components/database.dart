import 'package:cloud_firestore/cloud_firestore.dart';
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
  // List<Map<String, dynamic>> _dataList = [];

  @override
  void initState(){
    super.initState();

    getData();
  }
  getData() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _dbService.read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var userData = snapshot.data![index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(userData['name']),
                subtitle: Text('Age: ${userData['age']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showUpdateDialog(context, snapshot.data![index].id,userData['name'],userData['age'])
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmationDialog(context, snapshot.data![index].id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          _showDialog(context);
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
              onPressed: () async {
                if (_name.text.isNotEmpty && _age.text.isNotEmpty) {
                  await _dbService.create(
                    name: _name.text,
                    age: int.parse(_age.text),
                  );
                  Navigator.of(context).pop();
                } else {
                  // Tampilkan pesan error jika input kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
  void _showUpdateDialog(BuildContext context, String documentId, String currentName, int currentAge) {
    final _updatedName = TextEditingController(text: currentName);
    final _updatedAge = TextEditingController(text: currentAge.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: _updatedName,
                  decoration: InputDecoration(hintText: "Enter updated name")
              ),
              TextField(
                  controller: _updatedAge,
                  decoration: InputDecoration(hintText: "Enter updated age"),
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
              child: Text('Update'),
              onPressed: () async {
                if (_updatedName.text.isNotEmpty && _updatedAge.text.isNotEmpty) {
                  await _dbService.update(
                    documentId: documentId,
                    name: _updatedName.text,
                    age: int.parse(_updatedAge.text),
                  );
                  Navigator.of(context).pop();
                  setState(() {}); // Refresh the list
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this item?"),
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
                await _dbService.delete(documentId);
                Navigator.of(context).pop();
                setState(() {});  // Refresh the list
              },
            ),
          ],
        );
      },
    );
  }
}

