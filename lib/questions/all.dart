//  Question:  
// Design and develop a "Task Manager App" using Flutter that allows users to manage their daily tasks efficiently.
// Your app should include the following features and widgets:  

//  1. Splash Screen  
// - Implement a splash screen that displays the app logo for a few seconds before navigating to the home screen.  

//  2. Home Screen  
// - Use a Drawer widget to provide navigation options:  
//   - Tasks (Default screen)  
//   - Completed Tasks  
//   - Profile  

// - Add a CurvedNavigationBar at the bottom with three tabs:  
//   - All Tasks  
//   - In-Progress Tasks  
//   - Completed Tasks  

//  3. Task List Screen  
// - Display tasks in a ReorderableListView where users can rearrange tasks based on priority.  
// - Each task should have:  
//   - A Checkbox widget to mark completion.  
//   - A Dismissible widget to delete tasks with a swipe.  
//   - A CircleAvatar showing the task’s priority level (Low, Medium, High).  

//  4. Adding New Tasks  
// - Provide a floating button to add a new task.  
// - Clicking the button should open a ModalBottomSheet with a TextField for entering task details.  
// - Use a TextEditingController to manage input data.  
// - Add a Stepper widget for setting the task's priority level.  

//  5. Task Details Screen  
// - When clicking on a task, navigate to a detailed screen using the Navigator.  
// - Show task details, including a Checkbox for completion.  
// - Provide an Edit button to update task details.  

//  6. Notifications and Feedback  
// - Show a SnackBar when:  
//   - A task is added.  
//   - A task is marked as completed.  
//   - A task is deleted.  

//  7. Profile Screen  
// - Include a TabBar to switch between:  
//   - User Info (Shows name, email, profile picture using CircleAvatar).  
//   - App Settings (Theme toggle, notifications).  

//  Bonus Features (Optional):  
// - Use SharedPreferences to store tasks locally.  
// - Allow users to filter tasks based on their status.  

// ---

//  Expected Outcome:  
// A functional Task Manager App that effectively demonstrates multiple Flutter widgets and concepts while providing a seamless user experience.  

// Would you like a starter template for this, or do you want to build it from scratch? 😊

import 'package:flutter/material.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}