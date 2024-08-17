import 'package:flutter/material.dart';
import 'package:tracking_flutter/models/variable.dart';

class SaveVariable extends StatefulWidget {
  const SaveVariable({super.key});

  @override
  State<SaveVariable> createState() => _SaveVariableState();
}

class _SaveVariableState extends State<SaveVariable> {
  final _judul = TextEditingController();
  final _lirik = TextEditingController();
  List<Variable> variable = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tab(child: Text("Save variable")),
      body: ListView.builder(
        itemCount: variable.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(variable[index].title),
            subtitle: Text(variable[index].body)
          );
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Form Coba'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: _judul,
                    decoration: InputDecoration(hintText: "Enter your title song")
                ),
                TextField(
                    controller: _lirik,
                    decoration: InputDecoration(hintText: "Enter your lyric"),
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
                  if (_judul.text.isNotEmpty && _lirik.text.isNotEmpty) {
                    setState(() {
                      variable.add(Variable(title: _judul.text, body: _lirik.text));
                    });
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields')),
                    );
                  }
                },
              ),
            ],
          );
        }
    );
  }
}
