import 'package:bobo_cus/hive_service/hive_service.dart';
import 'package:bobo_cus/notification_service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var appBarTitle = '';
  TextEditingController textController = TextEditingController();
  HiveService hiveService = HiveService();
  final box = Hive.box("mybox"); // loads box

  // bool _isOn = false;
  bool _isDark = true;

  @override
  void initState() {
    super.initState();
    loadTitle();
    loadToggleTheme();
  }

  Future<void> loadTitle() async {
    final savedTitle = await hiveService.getData(box, 'title');
    setState(() {
      appBarTitle = savedTitle;
    });
  }

  Future<void> loadToggleTheme() async {
    final theme = await hiveService.getData(box, 'theme');
    setState(() {
      _isDark = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _isDark ? Colors.black : Colors.amber,
          foregroundColor: _isDark ? Colors.white : Colors.black,
          elevation: 14,
          title: Text(
              appBarTitle.isNotEmpty ? appBarTitle : 'Customizer App Title'),
        ),
        backgroundColor: _isDark ? Colors.black : Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: 'Enter a new app title'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Save the title to the box
                      saveAppTitle(textController.text);
                    },
                    child: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    _isDark ? "Light theme" : "Dark theme",
                    style: TextStyle(
                        fontSize: 20,
                        color: _isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Switch(
                      value: _isDark,
                      onChanged: (value) {
                        toggleTheme(value);
                      }),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  int timer = 5;
                  NotificationService.scheduleNotification(
                      "Winner 😘🏆", "Call ☎️ 7721900 for more details in {$timer}" , timer);
                },
                child: const Text("Notification trigger")),
            ElevatedButton(
                onPressed: () {
                  NotificationService.showNotification();
                },
                child: const Text("Show Notification")),
            Divider(),
          ],
        ));
  }

  void saveAppTitle(String title) {
    // Save the title to the box

    if (title.isNotEmpty) {
      hiveService.putData(box, "title", title);
      setState(() {
        appBarTitle = title;
      });
      textController.clear();
    }
  }

  void toggleTheme(bool value) {
    hiveService.putData(box, "theme", value);
    setState(() {
      _isDark = value;
    });
  }
}
