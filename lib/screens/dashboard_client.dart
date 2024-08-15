import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flutter/screens/category.dart';
import 'package:tracking_flutter/screens/database.dart';
import 'package:tracking_flutter/screens/login_screen.dart';
import 'package:tracking_flutter/services/remote_service.dart';

import '../models/category.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({super.key});

  @override
  State<DashboardClient> createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("category"),
                icon: Icon(Icons.category),
              ),
              Tab(
                child: Text("person"),
                icon: Icon(Icons.person),
              ),
              Tab(
                child: Text("menu"),
                icon: Icon(Icons.restaurant_menu),
              ),
              Tab(
                child: Text("contact"),
                icon: Icon(Icons.perm_contact_calendar_rounded),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
          Center(
          child: CategoryScreen(),
          ),
          Center(
          child: Data(),
          ),
          Center(
          child: Text("It's sunny here"),
          ),
          Center(
          child: Text("It's sunny here"),
          ),
          ],
        )
      ),
    );
  }
}
