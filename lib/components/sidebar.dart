import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Tiandhika'),
              accountEmail: Text('Tiandhika@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Icon(Icons.person),),
            ),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text("Home"),
          ),
        ],
      )
    );
  }
}
