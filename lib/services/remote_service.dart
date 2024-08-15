import 'package:http/http.dart' as http;
import 'package:tracking_flutter/models/category.dart';

class RemoteService{

  Future<List<Category>?> getCategories() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.200.100:8000/api/categories');
    var response = await client.get(uri);
    if (response.statusCode == 200){
      var json = response.body;
      return categoryFromJson(json);
    }
  }
}