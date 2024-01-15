import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_gui/models/category.dart';
import 'package:music_app_gui/views/components/responsive/desktop_body.dart';
import 'package:music_app_gui/views/components/responsive/mobile_body.dart';
import 'package:music_app_gui/views/components/responsive/responsive_layout.dart';
import 'package:music_app_gui/views/components/video_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Category>? category;
  late Future<List<Category>>? categories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategory();
  }

  Future<Category> getCategory() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/music/categories/1/'));
    if (response.statusCode == 200) {
      return Category.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load category: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: MobileBody(), desktopBody: DesktopBody());
  }
}
