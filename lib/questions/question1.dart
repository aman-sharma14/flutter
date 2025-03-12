import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStepper(),
    );
  }
}

class MyStepper extends StatefulWidget {
  const MyStepper({super.key});

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _uid = new TextEditingController();
  final TextEditingController _class = new TextEditingController();
  final TextEditingController _email = new TextEditingController();

  int _currentStep = 0;

  
  @override
  Widget build(BuildContext context) {
     Widget _content(_controller,text){
      return TextField(
        controller: _controller,
        decoration: InputDecoration(label: text),
      );
    }

    Widget review(){
      return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Name: ${_name.text}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("UID: ${_uid.text}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Class: ${_class.text}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Email: ${_email.text}")
            ),
          
          ],
        ),
      );
    }

    List<Step> _steps = [
      Step(title: Text("Name"), content: _content(_name,Text("Enter Your Name"))),
      Step(title: Text("Uid"), content: _content(_uid,Text("Enter Your UID"))),
      Step(title: Text("Class"), content: _content(_class,Text("Enter Your Class"))),
      Step(title: Text("Email"), content: _content(_email,Text("Enter Your Email"))),
      Step(title: Text("Review"), content: review())
    ];

   
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),

      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue:() {
          if(_currentStep<4){
            setState(() {
              _currentStep++;
            });
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Form Submitted")
              )
            );

            Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage()));
          }
        },
        onStepCancel: () {
          if(_currentStep>0){
           setState(() {
              _currentStep--;
           });
          }
        },
        steps: _steps,
      ),
    );
  }


  
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Text("Form Submitted")
      ),
    );
  }
}