// 5. Navigation and Curved Navigation Bar  
// Task:  
//  Implement a Curved Navigation Bar with three screens:  
//   1. Home (Contains a welcome message)  
//   2. Gallery (Displays images in a grid view)  
//   3. Settings (Contains a Drawer and a TextField for entering username)  


import 'package:flutter/material.dart';

String _name = "None";

class Question5 extends StatefulWidget {
  const Question5({super.key});

  @override
  State<Question5> createState() => _Question5State();
}

class _Question5State extends State<Question5> {
  List _screens = [Home(),Gallery(),Settings()];
  int i = 0;
  // final TextEditingController _controller =  TextEditingController();
  // String _name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Question 5"),),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text(_name)),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: (){
                setState(() {
                  i=0;
                  
                });
                Navigator.pop(context);
              },
              
            ),
            ListTile(
              title: Text("Gallery"),
              leading: Icon(Icons.image),
              onTap: (){
                setState(() {
                  i=1;
                  
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: (){
                setState(() {
                  i=2;
                  
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[i],
    );
  }

  
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Welcome! $_name");
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _controller =  TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter Your Name: "),
          TextField(
            controller: _controller,
            decoration: InputDecoration(label: Text("username")),
          ),
          ElevatedButton(onPressed: () {
            setState(() {
              _name = _controller.text;
            });
          }, child: Text("Change USername"))
        ],
      ),
    );
  }
}

class Gallery extends StatelessWidget {
   final List<String> _links = [
    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg",
    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg",
    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg",
    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg"
  ];
  Gallery({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,mainAxisSpacing: 10, crossAxisSpacing: 10,
        children: <Widget>[
          for(int i=0; i<_links.length; i++)
          Card(
            child: Image.network(_links[i]),
          )
        ],
      )
    );
  }
}