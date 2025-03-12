import 'package:flutter/material.dart';

class ModalBottomSheetExample extends StatelessWidget {
  const ModalBottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modal Bottom Sheet Example"),
      ),
      body: Center(
        child: ElevatedButton(
        onPressed: (){
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context){
              return Container(
                height: 200,
                // width: double.infinity,
                child: Center(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("this is mbs"),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Go back"))
                    ],

                  ),
                )
              );
            }
          );
        }, 
        child: Text("click to view modalBottomSheet")
      ),
      )
    );
  }
}


class CircleAvatarEg extends StatelessWidget {
  const CircleAvatarEg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circle Avatar"),
      ),
      body: Center(
        child: CircleAvatar(
          
            // Priority: `radius` > `minRadius` & `maxRadius`
            // radius: 40, // This fixes the size at 80x80 (radius * 2)

            // If `radius` is removed, min/maxRadius define a flexible size
            minRadius: 300,  // Avatar won't shrink smaller than 60x60
            maxRadius: 500,  // Avatar won't grow beyond 100x100

            // Background Image (Takes Priority Over `backgroundColor`)
            backgroundImage: NetworkImage("https://wrong-url.com/image.jpg"), 

            // Error Handling for Background Image
            onBackgroundImageError: (error, stackTrace) {
              print("Error loading image: $error");
            },

            // Background Color (Only visible if `backgroundImage` fails)
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            

            //foreground color: used to specify color for child widget
            foregroundColor: const Color.fromARGB(255, 0, 255, 225),

            //highest priority overrides everything
            foregroundImage: NetworkImage("https://ih1.redbubble.net/image.5479170750.3439/st,small,507x507-pad,600x600,f8f8f8.jpg"),
            
            // Child (Ignored if `backgroundImage` is set successfully)
            //child: Icon(Icons.person, size: 40, color: Colors.white),
            child: Text("AS"), //text will be red
          ),
      ),
    );
  }
}

//priority
//`foregroundImage` > `backgroundImage` > `child` > `backgroundColor` > `radius` > (`minRadius`, `maxRadius`)


//-------------------------------------------------------------------------------------------------------------------------------

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List _screens = [
      HomeScreen(), Explore(), Settings()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Center(child: Text("Welcome User!"),)),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _index = 0;
                });

                
              },
            ),
            ListTile(
              leading: Icon(Icons.explore),
              title: Text("Explore"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _index = 1;
                });

                
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _index = 2;
                });

                
              },
            ),
          ],
        ),
      ),
      body: _screens[_index],
      
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("HomeScreen"),
    );
  }
}

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Explore"),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings"),
    );
  }
}

//------------------------------------------------------------------------------------------------------------------------------------

class ReOrderableExample extends StatefulWidget {
  const ReOrderableExample({super.key});

  @override
  State<ReOrderableExample> createState() => _ReOrderableExampleState();
}

class _ReOrderableExampleState extends State<ReOrderableExample> {

  final List <String> _items = List<String>.generate(10,(int i) => "Item $i"); //generates a list of 10 string variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ReorderableListView(
      onReorder: (oldIndex,newIndex){
        setState(() {
          if(oldIndex<newIndex){
          newIndex--;
        }

        final String _item = _items.removeAt(oldIndex);
        _items.insert(newIndex, _item);
        });
      },
      children: <Widget>[
        for(int i=0; i<_items.length; i++)
          ListTile(
            
            key: Key('$i'),
            tileColor: i%2 == 0 ? Colors.black45 : Colors.black26,
            title: Text(_items[i]),
            
          )
        
      ], 
      
    ),
    );
  }

}

class CheckBoxExample extends StatefulWidget {
  const CheckBoxExample({super.key});

  @override
  State<CheckBoxExample> createState() => _CheckBoxExampleState();
}

class _CheckBoxExampleState extends State<CheckBoxExample> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Checkbox(
              value: isChecked, 
              onChanged: (bool? newVal){
                isChecked = newVal!;
              },
              activeColor: Colors.greenAccent,
              checkColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            Text(
              isChecked ? "Subscribed" : "Subscribe"
            )
          ],
        ),
      ),
    );
  }
}