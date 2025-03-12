import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<Map<String, bool>> _tasks =
      List.generate(5, (int i) => {"Task $i": false});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) newIndex--;
                setState(() {
                  final task = _tasks.removeAt(oldIndex);
                  _tasks.insert(newIndex, task);
                });
              },
              children: [
                for (int i = 0; i < _tasks.length; i++)
                  Dismissible(
                    key: ValueKey(_tasks[i].keys.first),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(i);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text(_tasks[i].keys.first),
                      tileColor: i % 2 == 0
                          ? const Color.fromARGB(255, 160, 219, 255)
                          : Colors.white,
                      trailing: Checkbox(
                        value: _tasks[i][_tasks[i].keys.first],
                        onChanged: (bool? newVal) {
                          setState(() {
                            _tasks[i][_tasks[i].keys.first] = newVal!;
                          });
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              
              onPressed: () {
                _showAddTaskDialog(context);
              },
              child: const Text("Add Task"),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    _controller.clear();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter Task:", style: TextStyle(fontSize: 18)),
              TextField(controller: _controller),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      _tasks.add({_controller.text: false});
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text("Done"),
              ),
            ],
          ),
        );
      },
    );
  }
}
