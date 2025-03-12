import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  bool isClicked = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
                Text("Enter Weight: "),
                TextField(
                  controller: _weight,
                  decoration: InputDecoration(label: Text("kgs")),
                ),
             
            
                Text("Enter Height: "),
                TextField(
                  controller: _height,
                  decoration: InputDecoration(label: Text("metres")),
                ),
              
            Padding(padding: EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: (){
                String w = _weight.text;
                String h = _height.text;
                

                if(w.isEmpty || h.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty fields")));
                }
                else{
                  setState(() {
                    isClicked = true;
                  });
                }
              }, 
              child: Text("Calculate BMI")
            ),),
            if(isClicked)
            result(double.parse(_weight.text), double.parse(_height.text))
          ],
        ),
      ),
    );
  }
}


String bmiResult(bmi){
  if(bmi<18.5){
    return "Underweight";
  }
  else if(bmi<25){
    return "Normal Weight";
  }
  else if(bmi<30){
    return "OverWeight";
  }
  else{
    return "Obese";
  }
}

Widget result(w,h){
  double bmi = w/(h*h);
  String result = bmiResult(bmi);

  return Container(
    child: Text("Bmi: $bmi \nYou are $result"),
  );
}