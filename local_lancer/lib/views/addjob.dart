import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_lancer/views/taskjob.dart';

class Addjob extends StatefulWidget {
  final String userName;
  Addjob({this.userName});

  @override
  _AddjobState createState() => _AddjobState();
}

class _AddjobState extends State<Addjob> {
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text('Local',
            style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 21))),
            Text('Lancer',
            style:GoogleFonts.oswald(textStyle: TextStyle(color: Color(0xffff2d55),fontWeight: FontWeight.w800,fontSize: 21))),
          ]
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                  image: AssetImage('Assets/image2.jpg'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter
                )
              ),
          ),
        ),
        Container(
          color: Colors.black12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 240),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 23),
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add',
                      style:GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30))),
                      Text('Job',
                    style:GoogleFonts.prompt(textStyle: TextStyle(color: Color(0xffff2d55),fontWeight: FontWeight.w600,fontSize: 30))),
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: jobNameController,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task Name',
                        prefixIcon: Icon(Icons.handyman_outlined),
                        labelStyle: TextStyle(
                          fontSize: 15
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    controller: cityController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      prefixIcon: Icon(Icons.location_city_outlined),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    obscureText: false,
                    controller: stateNameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'State',
                      prefixIcon: Icon(Icons.add_location),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10)
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      final dbRefUser = FirebaseDatabase.instance.reference().child("User").child(widget.userName);
                      final dbRefData= FirebaseDatabase.instance.reference().child("Jobs");
                      final DateTime now=DateTime.now();
                      final DateFormat formatter = DateFormat('dd-MM-yyyy');
                      final String formatted = formatter.format(now);
                      dbRefUser.once().then((DataSnapshot snapshot){
                        print('Data : ${snapshot.value}');
                        Map<dynamic, dynamic> data = snapshot.value;
                        dbRefData.once().then((DataSnapshot snapshots){
                          List<dynamic> value=snapshots.value;
                          
                          dbRefData.child("${value.length}").set(
                            {
                              "User": "${widget.userName}",
                              'phone': "${data['phone']}",
                              'city': "${cityController.text}",
                              'state': "${stateNameController.text}",
                              'email': "${data['email']}",
                              'job': "${jobNameController.text}",
                              'published_on': "${formatted}"
                            });
                        });
                      });
                      showAlertDialog(context, widget.userName);
                    },//since this is only a UI app
                    child: Text('ADD',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    color: Color(0xffff2d55),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
    );
  }
}

void showAlertDialog(BuildContext context, String uNm) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.popUntil(context,ModalRoute.withName('/taskjob'));
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Taskjob(uName: uNm)));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Successfull!"),
    content: Text("Job added successfully!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}