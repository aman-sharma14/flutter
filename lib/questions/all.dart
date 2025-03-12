/*Build a Task Manager app with the following features:
1. Splash Screen - Shows app logo before navigating to the home screen.
2. Home Screen:
   - Drawer with navigation: Tasks, Completed Tasks, Profile.
   - CurvedNavigationBar with three tabs: All Tasks, In-Progress, Completed.

3. Task List:
   - ReorderableListView to rearrange tasks.
   - Each task has:
     - Checkbox (mark complete), Dismissible (delete), CircleAvatar (priority level).

4. Add Task:
   - Floating Button to open a ModalBottomSheet.
   - TextField (task details) with TextEditingController.
   - Stepper for priority selection.

5. Task Details:
   - Clicking a task navigates using Navigator.
   - Task details + Checkbox for completion.
   - Edit button to update details.

6. Notifications & Feedback:
   - SnackBar on task add, complete, delete.

7. Profile Screen:
   - TabBar with User Info (CircleAvatar) & App Settings.

Bonus: Use SharedPreferences for local storage & allow task filtering.
*/

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

List<Map<String, dynamic>> _tasks = [];
String name = "";
String pfp = "";
String email = "";

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List _screens = [
    HomeScreen(),
    CompletedTasks(),
    InProgressTasks(),
    Profile(),
  ];

  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager App"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Welcome! $name")),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentScreen = 0;
                });
              },
            ),
            ListTile(
              title: Text("Completed Tasks"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentScreen = 1;
                });
              },
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentScreen = 3;
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.done_all,
            color: Colors.white,
          ),
          Icon(
            Icons.incomplete_circle,
            color: Colors.white,
          ),
        ],
        buttonBackgroundColor: Colors.black, // Matches navigation bar
        backgroundColor: Colors.white, // Matches screen background
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        color: Colors.black,

        onTap: (value) {
          setState(() {
            currentScreen = value;
          });
        },
      ),
      body: _screens[currentScreen],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("All Tasks"),
          Expanded(
              child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex--;
              }
              setState(() {
                final task = _tasks.removeAt(oldIndex);
                _tasks.insert(newIndex, task);
              });
            },
            children: <Widget>[
              for (int i = 0; i < _tasks.length; i++)
                GestureDetector(
                  key: Key(_tasks[i]['title']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskDetails(task: _tasks[i])));
                  },
                  child: Dismissible(
                    key:
                        ValueKey(_tasks[i]['title']), //allows only unique tasks
                    background: Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(i);
                      });
                      showSnackBar("task deleted ", context);
                    },
                    child: ListTile(
                      title: Text(_tasks[i]['title']),
                      tileColor: i % 2 == 0
                          ? const Color.fromARGB(255, 0, 204, 255)
                          : const Color.fromARGB(255, 172, 238, 255),
                      trailing: Checkbox(
                          value: _tasks[i]['completed'],
                          onChanged: (bool? newVal) {
                            setState(() {
                              _tasks[i]['completed'] = newVal!;
                            });

                            if (_tasks[i]['completed']!) {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as complete",
                                  context);
                            } else {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as incomplete",
                                  context);
                            }
                          }),
                      leading: _tasks[i]['priority'],
                    ),
                  ),
                )
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add Task"),
                        MyStepper(onTaskAdded: () {
                          setState(() {
                            
                          });
                        })
                      ],
                    ),
                  );
                });
          }),
    );
  }
}

class MyStepper extends StatefulWidget {
  final Function onTaskAdded;

  const MyStepper({super.key, required this.onTaskAdded});

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _priority = TextEditingController();
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stepper(
        steps: [
          Step(
            title: const Text("Title"),
            content: TextField(
              controller: _title,
              decoration:
                  const InputDecoration(label: Text("Enter task title")),
            ),
          ),
          Step(
            title: const Text("Description"),
            content: TextField(
              controller: _description,
              decoration:
                  const InputDecoration(label: Text("Enter task description")),
            ),
          ),
          Step(
            title: const Text("Priority"),
            content: TextField(
              controller: _priority,
              decoration:
                  const InputDecoration(label: Text("Enter task priority")),
            ),
          )
        ],
        currentStep: currentStep,
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        onStepContinue: () {
          if (currentStep < 2) {
            setState(() {
              currentStep++;
            });
          } else {
            if (_title.text.isEmpty) {
              showSnackBar("Enter title", context);
            } else {
              if (_priority.text == "low" ||
                  _priority.text == "medium" ||
                  _priority.text == "high") {
                setState(() {
                  addTask(_title.text, _description.text, _priority.text);
                });
                showSnackBar("Task Added Successfully", context);
                Navigator.pop(context);
                _title.clear();
                _description.clear();
                _priority.clear();
                widget.onTaskAdded();
              } else {
                showSnackBar(
                    "priority can be either low medium or high", context);
              }
            }
          }
        },
      ),
    );
  }
}

class TaskDetails extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title: ${task['title']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Description: ${task['description'] ?? 'No description'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Priority: ${task['pri'] ?? 'Unknown'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Status: ${task['completed'] ? 'Completed' : 'Pending'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Go Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Completed Tasks"),
        Expanded(
            child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex--;
            }
            setState(() {
              final task = _tasks.removeAt(oldIndex);
              _tasks.insert(newIndex, task);
            });
          },
          children: <Widget>[
            for (int i = 0; i < _tasks.length; i++)
              if (_tasks[i]['completed']!)
                GestureDetector(
                  key: Key(_tasks[i]['title']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskDetails(task: _tasks[i])));
                  },
                  child: Dismissible(
                    key:
                        ValueKey(_tasks[i]['title']), //allows only unique tasks
                    background: Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(i);
                      });
                      showSnackBar("task deleted ", context);
                    },
                    child: ListTile(
                      title: Text(_tasks[i]['title']),
                      tileColor: i % 2 == 0
                          ? const Color.fromARGB(255, 0, 204, 255)
                          : const Color.fromARGB(255, 172, 238, 255),
                      trailing: Checkbox(
                          value: _tasks[i]['completed'],
                          onChanged: (bool? newVal) {
                            setState(() {
                              _tasks[i]['completed'] = newVal!;
                            });

                            if (_tasks[i]['completed']!) {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as complete",
                                  context);
                            } else {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as incomplete",
                                  context);
                            }
                          }),
                      leading: _tasks[i]['priority'],
                    ),
                  ),
                )
          ],
        )),
      ],
    ));
  }
}

class InProgressTasks extends StatefulWidget {
  const InProgressTasks({super.key});

  @override
  State<InProgressTasks> createState() => _InProgressTasksState();
}

class _InProgressTasksState extends State<InProgressTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("InProgress Tasks"),
        Expanded(
            child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex--;
            }
            setState(() {
              final task = _tasks.removeAt(oldIndex);
              _tasks.insert(newIndex, task);
            });
          },
          children: <Widget>[
            for (int i = 0; i < _tasks.length; i++)
              if (!_tasks[i]['completed']!)
                GestureDetector(
                  key: Key(_tasks[i]['title']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskDetails(task: _tasks[i])));
                  },
                  child: Dismissible(
                    key:
                        ValueKey(_tasks[i]['title']), //allows only unique tasks
                    background: Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(i);
                      });
                      showSnackBar("task deleted ", context);
                    },
                    child: ListTile(
                      title: Text(_tasks[i]['title']),
                      tileColor: i % 2 == 0
                          ? const Color.fromARGB(255, 0, 204, 255)
                          : const Color.fromARGB(255, 172, 238, 255),
                      trailing: Checkbox(
                          value: _tasks[i]['completed'],
                          onChanged: (bool? newVal) {
                            setState(() {
                              _tasks[i]['completed'] = newVal!;
                            });

                            if (_tasks[i]['completed']!) {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as complete",
                                  context);
                            } else {
                              showSnackBar(
                                  "${_tasks[i]['title']} has been marked as incomplete",
                                  context);
                            }
                          }),
                      leading: _tasks[i]['priority'],
                    ),
                  ),
                )
          ],
        )),
      ],
    ));
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pfp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                child: Row(
                  children: [Text("Profile"), Icon(Icons.person)],
                ),
              ),
              Tab(
                child: Row(
                  children: [Text("Settings"), Icon(Icons.settings)],
                ),
              )
            ]),
          ),
          body: TabBarView(children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(pfp),
                    foregroundColor: Colors.grey,
                    radius: 40,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Name: $name"),
                  Text("Email: $email")
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: _name,
                    decoration:
                        InputDecoration(label: Text("Enter new name: ")),
                  ),
                  TextField(
                    controller: _email,
                    decoration:
                        InputDecoration(label: Text("Enter new email: ")),
                  ),
                  TextField(
                    controller: _pfp,
                    decoration:
                        InputDecoration(label: Text("Enter new image url: ")),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_name.text.isNotEmpty) {
                            name = _name.text;
                          }

                          if (_email.text.isNotEmpty) {
                            email = _email.text;
                          }

                          if (_pfp.text.isNotEmpty) {
                            pfp = _pfp.text;
                          }
                        });
                        _name.clear();
                        _email.clear();
                        _pfp.clear();
                        showSnackBar("Details Updated", context);
                      },
                      child: Text("Update"))
                ],
              ),
            )
          ]),
        ));
  }
}

void showSnackBar(msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 2000),
    ),
  );
}

void addTask(String title, String description, String priority) {
  Widget p;

  if (priority == 'low') {
    p = Icon(Icons.low_priority);
  } else if (priority == 'medium') {
    p = Icon(Icons.trending_flat);
  } else {
    p = Icon(Icons.priority_high);
  }

  _tasks.add({
    'title': title,
    'completed': false,
    'description': description,
    'priority': p,
    'pri': priority
  });
}
