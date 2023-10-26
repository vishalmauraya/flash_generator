import 'package:flashlight/flashlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    MaterialApp(
      home: FlashLight(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
class FlashLight extends StatefulWidget{
  @override
  State createState() {
    return _FlashLight();
  }
}

class _FlashLight extends State{
  bool hasflashlight = false; //to set is there any flashlight ?
  bool isturnon = false; //to set if flash light is on or off
  IconData flashicon = Icons.flash_off; //icon for lashlight button
  Color flashbtncolor = Colors.deepOrangeAccent; //color for flash button

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      //we use Future.delayed because there is async function inside it.
      bool istherelight = await Flashlight.hasFlashlight;
      setState(() {
        hasflashlight = istherelight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:AppBar(title:Text("Flash Light")),
        body: Container(
          width:double.infinity,
          height:MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          //set width and height of outermost wrapper to 100%;
          child:flashlightbutton(),
        )
    );
  }

  Widget flashlightbutton(){
    if(hasflashlight){
      return Column(children: [
        Text("Your device has flash light."),
        Text(isturnon ? "Flash is ON" : 'Flash is OFF'),

        Container(
            child: ElevatedButton.icon(
              onPressed: (){
                if(isturnon){
                  //if light is on, then turn off
                  Flashlight.lightOff();
                  setState(() {
                    isturnon = false;
                    flashicon = Icons.flash_off;
                    flashbtncolor = Colors.deepOrangeAccent;
                  });
                }else{
                  //if light is off, then turn on.
                  Flashlight.lightOn();
                  setState(() {
                    isturnon = true;
                    flashicon = Icons.flash_on;
                    flashbtncolor = Colors.greenAccent;
                  });
                }
              },
              icon: Icon(flashicon, color: Colors.white,),
              // box  color: flashbtncolor,
              label: Text(isturnon ? 'TURN OFF' : 'TURN ON',
                style: TextStyle(color: Colors.white),
              ),

            )
        )

      ],);
    }else{
      return Text("Your device do not have flash light.");
    }
  }

}