import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tracking_flutter/services/remote_service.dart';

import '../models/category.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({super.key});

  @override
  State<DashboardClient> createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  List<Category>? categories;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();

   getData();
  }
  getData() async {
    categories = await RemoteService().getCategories();
    if(categories != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: categories?.length,
        itemBuilder:(context, index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text(categories![index].name),
               Image(
                 image: MemoryImage(base64Decode(categories![index].icon)),
                 width: 100,
                 height: 100,
                 fit: BoxFit.cover,
               ),
               Text(categories![index].description)
             ],
            )
          );
        },
      ),
    );
  }
}
