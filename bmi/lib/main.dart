import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Mass Index',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.pink ,
      ),
      home: const MyHomePage(title: 'Check Your BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
 var bgColor = Colors.cyan.shade200;
  // var bgColor= Colors.indigo.shade200;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("BMI:                              Body Mass Index"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: bgColor,
          child: Center(
            child: Container(

              width: 300,

              child: Column(
                mainAxisAlignment:MainAxisAlignment.center ,
                   children: [
                     Text('BMI' ,style: TextStyle(fontSize: 34 ,fontWeight: FontWeight.w700
                     ),),
                     SizedBox(height: 45,),
                   TextField(
                     controller: wtController,
                     decoration: InputDecoration(
                       label : Text('Enter Your Weight in KG'),
                       prefixIcon: Icon(Icons.line_weight)
                     ),
                        keyboardType: TextInputType.number,
                   ),
                      SizedBox(height: 21,),
                     TextField(
                       controller: ftController,
                       decoration: InputDecoration(
                         label: Text('Enter your Height in FEET'),
                         prefixIcon: Icon(Icons.height),

                       ),
                       keyboardType: TextInputType.number,
                     ),
                         SizedBox(height: 21,),
                     TextField(
                         controller : inController,
                         decoration: InputDecoration(
                           label: Text('Enter your Height in Inches'),
                         prefixIcon: Icon(Icons.height),
                         ),
                     keyboardType: TextInputType.number,
                     ),
                     SizedBox(height: 21,),
                     ElevatedButton(onPressed: (){

                       var wt = wtController.text.toString();
                       var ft = ftController.text.toString();
                       var inch = inController.text.toString();



                       if(wt !="" && ft!="" && inch !="") {

                         // BMI CALculation

                         var iWt = int.parse(wt);
                         var iFt = int.parse(ft);
                         var iInch = int.parse(inch);


                         var tInch = (iFt * 12) + iInch;

                         var tCm = tInch * 2.54;

                           var tM = tCm/100;

                         var bmi = iWt/(tM*tM);

                         var msg="";
                         if(bmi>25){
                           msg="You are OverWeight !!";
                           bgColor=Colors.orange.shade400;
                         }
                         else if(bmi<18){
                           msg="You are UnderWeight !!";
                           bgColor=Colors.red.shade200;
                         }
                         else{
                           msg="You are Healthy!!";
                           bgColor=Colors.green.shade500;
                         }

                         setState(() {
                         result = "$msg \n Your BMI is: ${bmi.toStringAsFixed(4)}";
                         });
                       }

                       else{
                                 setState(() {
                                   result="Please Fill all Required Blanks";

                                 });
                       }

                     }, child: Text('Calculate')),
                              Text("\n"),
                              Text("Hey  , WELCOME to Our App BodyMassIndex\n"),
                     SizedBox(height: 11,),

                     Text(result, style: TextStyle(fontSize: 19),)

                     //  TextButton(onPressed: (){
                     //
                     //  }, child: 'Reset' ),

                   ],


    ),
             ),
           ),
          ),
      )
      );
    }
   }
