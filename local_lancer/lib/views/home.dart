import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_lancer/views/signup.dart';
import 'package:local_lancer/views/taskjob.dart';

class Home extends StatefulWidget {
  Home({this.app});
  final FirebaseApp app;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  image: AssetImage('Assets/image1.jpg'),
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
          margin: EdgeInsets.only(top: 260),
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
                      Text('Sign',
                      style:GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30))),
                      Text('In',
                    style:GoogleFonts.prompt(textStyle: TextStyle(color: Color(0xffff2d55),fontWeight: FontWeight.w600,fontSize: 30))),
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: userNameController,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
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
                    obscureText: true,
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      final dbRefUser = FirebaseDatabase.instance.reference().child("User");
                      dbRefUser.once().then((DataSnapshot snapshot){
                        print('Data : ${snapshot.value}');
                        print(snapshot.value.toString().contains(userNameController.text));
                        if(snapshot.value.toString().contains(userNameController.text)){
                          Map<dynamic, dynamic> values=snapshot.value;
                            if(values[userNameController.text]["password"]==passwordController.text){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>Taskjob(uName: userNameController.text,))
                              );
                            }
                            else{
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Wrong Password!"),
                                  duration: Duration(seconds:1),
                                )
                              );
                              FocusScope.of(context).unfocus();
                            }
                          }
                        else{
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Username Not Found! Try Sign Up!"),
                                duration: Duration(seconds:1),
                              )
                            );
                            FocusScope.of(context).unfocus();
                          /*Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>Sign())
                          );*/
                        }
                      });
                    },//since this is only a UI app
                    child: Text('SIGN IN',
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
                /*Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),*/
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>Sign())
                      );
                    },
                    child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 15,
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
    );
  }
}
