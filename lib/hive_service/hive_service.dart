import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

 

  Future openBox() async {
    return await Hive.openBox("mybox");
  }

  Future<void> putData(Box box, String key, dynamic value) async {
    
    await box.put(key, value);
  }

  Future<dynamic> getData(Box box, String key) async{
    return await box.get(key);
  }

  Future<void> deleteData(Box box, String key) async {
    await box.delete(key);
  }

  Future<void> clearBox(Box box) async {
    
    await box.clear();
  }

  Future<void> closeBox(Box box) async {
    
    await box.close();
  }
}