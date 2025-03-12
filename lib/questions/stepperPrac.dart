import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProjectStepper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProjectStepper extends StatefulWidget {
  const ProjectStepper({super.key});

  @override
  State<ProjectStepper> createState() => _ProjectStepperState();
}

class _ProjectStepperState extends State<ProjectStepper> {
  int _index = 0;
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescriptionController = TextEditingController();
  final TextEditingController _teamMemberController = TextEditingController();
  String? _selectedRole;
  // ignore: unused_field
  final TextEditingController _timelineController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Management"),
      ),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index--;
            });
          }
        },
        onStepContinue: () {
          if (_index < 4) {
            setState(() {
              _index++;
            });
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Project Submitted Successfully!")),
            );
          }
        },
        steps: <Step>[
          Step(title: Text("Project Details"), content: projectDetails()),
          Step(title: Text("Team Members"), content: teamMembers()),
          Step(title: Text("Timeline"), content: timeline()),
          Step(title: Text("Budget"), content: budget()),
          Step(title: Text("Review & Submit"), content: reviewSubmit()),
        ],
      ),
    );
  }

  Widget projectDetails() {
    return Column(
      children: [
        TextField(
          controller: _projectNameController,
          decoration: InputDecoration(labelText: "Project Name"),
        ),
        TextField(
          controller: _projectDescriptionController,
          decoration: InputDecoration(labelText: "Project Description"),
        )
      ],
    );
  }

  Widget teamMembers() {
    return Column(
      children: [
        TextField(
          controller: _teamMemberController,
          decoration: InputDecoration(labelText: "Add Team Member"),
        ),
        DropdownButton<String>(
          value: _selectedRole,
          items: <String>['Role 1', 'Role 2', 'Role 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
          hint: Text("Select Role"),
        )
      ],
    );
  }

  Widget timeline() {
    return Column(
      children: [
        ListTile(
          title: Text("Start Date: ${_startDate != null ? _startDate!.toLocal().toString().split(' ')[0] : 'Select Date'}"),
          trailing: Icon(Icons.calendar_today),
          onTap: () => _selectDate(context, true),
        ),
        ListTile(
          title: Text("End Date: ${_endDate != null ? _endDate!.toLocal().toString().split(' ')[0] : 'Select Date'}"),
          trailing: Icon(Icons.calendar_today),
          onTap: () => _selectDate(context, false),
        ),
      ],
    );
  }

  Widget budget() {
    return TextField(
      controller: _budgetController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Budget',
      ),
    );
  }

  Widget reviewSubmit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Project Name: ${_projectNameController.text}"),
        Text("Project Description: ${_projectDescriptionController.text}"),
        Text("Team Member: ${_teamMemberController.text}"),
        Text("Role: ${_selectedRole ?? "Not selected"}"),
        Text("Start Date: ${_startDate != null ? _startDate!.toLocal().toString().split(' ')[0] : 'Not selected'}"),
        Text("End Date: ${_endDate != null ? _endDate!.toLocal().toString().split(' ')[0] : 'Not selected'}"),
        Text("Budget: ${_budgetController.text}"),
        SizedBox(height: 10),
      ],
    );
  }
}