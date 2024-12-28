import 'package:hive_flutter/hive_flutter.dart';

class ThemeService {
  static bool? isdark;

  Box box = Hive.box("mybox");

  static Future<void> initialize() async {
    
  }


}