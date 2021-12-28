import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: controller,
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          final data = ClipboardData(text: controller.text);
                          Clipboard.setData(data);

                          final snackBar = SnackBar(
                              content: Text(
                            "✓　Password Copied",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ));

                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        },
                      )),
                )),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final backgroundCoior = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed) ? Colors.pink : Colors.black);

    return ElevatedButton(
        style: ButtonStyle(backgroundColor: backgroundCoior),
        onPressed: () {
          final password = generatePassword();

          controller.text = password;
        },
        child: Text("Generate Password"));
  }

  String generatePassword(
      {bool hasLetters = true,
      bool hasNumbers = true,
      bool hasSpecial = true}) {
    final length = 20;
    final lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
    final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final special = '@#=+!\$%&?(){}';

    String chars = '';
    if (hasLetters) chars += '$lettersLowercase$lettersUppercase';
    if (hasNumbers) chars += '$numbers';
    if (hasSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
