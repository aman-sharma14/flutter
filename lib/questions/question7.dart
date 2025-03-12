//  7. Custom Modal Bottom Sheet for User Profile
// Task:
//  Create a user profile page with:
//    A CircleAvatar displaying a dummy user image
//    A button to edit profile, which opens a Modal Bottom Sheet
//    Inside the sheet, have a TextField to change the username and save

import 'package:flutter/material.dart';

class Question7 extends StatefulWidget {
  const Question7({super.key});

  @override
  State<Question7> createState() => _Question7State();
}

class _Question7State extends State<Question7> {
  final TextEditingController _controller = TextEditingController();
  String username = "";
  Widget _child = Icon(Icons.person);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: _child,
              backgroundColor: Colors.black,
              foregroundColor: Colors.greenAccent,
            ),
            Text("UserName: $username"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(label: Text("Enter Username")),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    label: Text("Enter Username")),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      username = _controller.text;
                                      _child = Text(username);
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: Text("Change username"))
                            ],
                          ),
                        );
                      });
                },
                child: Text("Edit PRofile"))
          ],
        ),
      ),
    );
  }
}
