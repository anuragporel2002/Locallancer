import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_lancer/views/home.dart';
import 'package:local_lancer/views/taskjob.dart';

class Sign extends StatefulWidget {
  Sign({this.app});
  final FirebaseApp app;

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailIDController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateNameController = TextEditingController();
    //FocusScopefinal _scaffoldKey= GlobalKey<ScaffoldState>();

    return Scaffold(
      //key: _scaffoldKey,
      /*appBar: AppBar(
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
      ),*/
      body: Stack(
      children: <Widget>[
        
        Container(
          width: MediaQuery.of(context).size.width,
          //margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: ListView(
              children: <Widget>[
                Container(

                ),
                Container(
                  margin: EdgeInsets.only(top: 23),
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Sign',
                      style:GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30))),
                      Text('Up',
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
                      controller: userController,
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
                    obscureText: false,
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.local_phone_outlined),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 20)
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    controller: emailIDController,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 20)
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
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    obscureText: false,
                    controller: cityController,
                    keyboardType: TextInputType.text,
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
                  margin: EdgeInsets.symmetric(vertical: 20)
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      final dbRefUser = FirebaseDatabase.instance.reference().child("User");
                      dbRefUser.once().then((DataSnapshot snapshot){
                        print('Data : ${snapshot.value}');
                        print(snapshot.value.toString().contains(userController.text));
                        if(! snapshot.value.toString().contains(userController.text)){
                          dbRefUser.child("${userController.text}").set(
                            {
                              'email': "${emailIDController.text}",
                              'phone': "${phoneController.text}",
                              'password': "${passwordController.text}",
                              'city': "${cityController.text}",
                              'state': "${stateNameController.text}",
                            }
                          );
                          //FocusScope.of(context).unfocus();
                          showAlert(context);
                        }
                        else{
                          //FocusScope.of(context).unfocus();
                          showAlertDialog(context);
                        }
                      });                   
                    },//since this is only a UI app
                    child: Text('SIGN UP',
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
                    onTap:(){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>Home())
                      );
                    },
                    child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )
                            ),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 15,
                              )
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

void showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("User Exists!"),
    content: Text("User already exists! Try Sign In!"),
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

void showAlert(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Login Successful!"),
    content: Text("Login Successful! Try Sign In!"),
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