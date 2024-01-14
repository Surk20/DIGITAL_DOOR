import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:josm/screens/first_screen.dart';
import 'package:josm/screens/qrScanScreen.dart';

class Greeting extends StatefulWidget {
  const Greeting({super.key});

  @override
  State<Greeting> createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        padding: EdgeInsets.all(25),
        color: Colors.white54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Thank You',style: TextStyle(fontSize: 20),),
            SizedBox(height: 50,),
            InkWell(
              onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>qrScanScreen()));},
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
                child: Text("Done",style: TextStyle(fontSize: 20),)
              ),
            ),
          ],
        ),
      ),
    )
      ;
  }
}
