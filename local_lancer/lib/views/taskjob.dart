import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_lancer/views/addjob.dart';

class Taskjob extends StatefulWidget {
  final String uName;
  Taskjob({this.uName});

  @override
  _TaskjobState createState() => _TaskjobState();
}

class _TaskjobState extends State<Taskjob> {
  List<dynamic> lists=[]; 
  final dbRefUser = FirebaseDatabase.instance.reference().child("Jobs");
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child:Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child:FutureBuilder(
                  future: dbRefUser.once(),
                  builder:(context,AsyncSnapshot<DataSnapshot> snapshot){
                    List<dynamic> value=snapshot.data.value;
                    List<dynamic> values=List.from(value.reversed);
                    print(values);
                    return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: values.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal:10),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget>[
                              Row(  
                                  children: <Widget>[
                                    Text(values[index]['job'],
                                    style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize:19))),
                                  ]
                                ),
                              Row(
                                children: <Widget>[
                                  Text('Customer : ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w300,fontSize:17))),
                                  Text(values[index]['User'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w300,fontSize:17))),
                                ]
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Email : ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(values[index]['email'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                ]
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Phone : ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(values[index]['phone'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                ]
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Location : ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(values[index]['city'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(', ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(values[index]['state'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                ]
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Published On : ',
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                  Text(values[index]['published_on'],
                                  style:GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w200))),
                                ]
                              )
                              ]
                            ),
                          )
                        );
                      }
                    );
                  }
                )
              )
            ]
          ),
        )
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>Addjob(userName: widget.uName)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffff2d55),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}