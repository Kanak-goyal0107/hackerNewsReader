import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/story_model.dart';

class HNApiService {


  static Future<List<int>> fetchTopStories() async {

    final response = await http.get(
      Uri.parse(
        'https://hacker-news.firebaseio.com/v0/topstories.json',
      ),
    );

    final List data = jsonDecode(response.body);

    return data.cast<int>();
  }


  static Future<Story> fetchStory(int id) async {

    final response = await http.get(
      Uri.parse(
        'https://hacker-news.firebaseio.com/v0/item/$id.json',
      ),
    );

    final data = jsonDecode(response.body);

    return Story.fromJson(data);
  }
}