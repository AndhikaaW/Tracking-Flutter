import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/remote_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
               // Text(categories![index].id.toString()),
               Text(categories?[index].name?? 'No Name'),
               Image(
                 image: MemoryImage(base64Decode(categories?[index].icon ?? 'No Icon')),
                 width: 100,
                 height: 100,
                 fit: BoxFit.cover,
               ),
                Text(categories?[index].description ?? 'No Description')
             ],
            )
          );
        },
      ),
    );
  }
}
