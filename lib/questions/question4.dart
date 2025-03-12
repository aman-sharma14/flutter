//  4. Tab Bar with Different Screens
// Task:
//  Implement a TabBar with three tabs:
//   1. Profile (Show user’s name with CircleAvatar)
//   2. Settings (Enable/Disable Notifications using Checkbox)
//   3. Info (Show a Modal Bottom Sheet with app details)

import "package:flutter/material.dart";

class Question4 extends StatefulWidget {
  const Question4({super.key});

  @override
  State<Question4> createState() => _Question4State();
}

class _Question4State extends State<Question4> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Question 4"),
              bottom: TabBar(tabs: [
                Tab(
                  text: "Profile",
                  icon: Icon(Icons.person),
                ),
                Tab(
                  text: "Settings",
                  icon: Icon(Icons.settings),
                ),
                Tab(
                  text: "Info",
                  icon: Icon(Icons.info),
                )
              ])),
          body: TabBarView(children: [
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.greenAccent,
                  radius: 50,
                  child: Text("JD"),
                ),
                Text("John Doe")
              ],
            )),
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? newVal) {
                    setState(() {
                      isChecked = newVal!;
                    });
                  },
                  activeColor: Colors.lightBlueAccent,
                  checkColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                Text(isChecked ? "Disable Notifications" : "Enable Notifications")
              ],
            )),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("App Name : Question 4"),
                                  Text("Version: 1.0"),
                                  Text("Developer: John Doe")
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text("View Info")),
            )
          ]),
        ));
  }
}
