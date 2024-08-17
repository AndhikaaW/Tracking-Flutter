import 'package:flutter/material.dart';
import 'package:tracking_flutter/components/database.dart';
import 'package:tracking_flutter/components/home_admin.dart';
import 'package:tracking_flutter/components/sidebar.dart';

class DashboardAdmin extends StatefulWidget {
  // const DashboardAdmin({super.key });
  final String message;
  final String password;
  const DashboardAdmin({Key? key, required this.message,required this.password}): super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _currentIndex = 0;
  late List<Widget> body;

  @override
  void initState() {
    super.initState();
    body = [
      HomeAdmin(message: widget.message, password: widget.password),
      const Icon(Icons.menu),
      Data()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(),
      // backgroundColor: Colors.green,
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label: 'menu',
              icon: Icon(Icons.menu)
          ),
          BottomNavigationBarItem(
              label: 'profile',
              icon: Icon(Icons.person)
          )
        ],
      ),
    );
  }
}