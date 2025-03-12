//  8. Dismissible Widget with SnackBar Undo  
// Task:  
//  Create a list of items where:  
//    Each item can be swiped left or right (Dismissible)  
//    When dismissed, show a SnackBar with an "Undo" button  

import 'package:flutter/material.dart';


class Question8 extends StatefulWidget {
  const Question8({super.key});

  @override
  State<Question8> createState() => _Question8State();
}

class _Question8State extends State<Question8> {
  final List<String> _items = List.generate(10, (int i)=> "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context,index){
          final item = _items[index];

          return Dismissible(
            key: Key('$index'),
            direction: DismissDirection.endToStart,
            onDismissed:(direction) {
              setState(() {
                _items.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$item dismissed"),
                  action: SnackBarAction(label: "Undo", onPressed:(){
                    setState(() {
                      _items.insert(index, item);
                    });
                  }),
                  
                )
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete),
            ), 
            child: ListTile(
              title: Text(item),
              tileColor: index%2==0 ? Colors.black87 : Colors.black54,
            ),
          );
        }
      )
    );
  }
}
