import 'package:flutter/material.dart';
import 'package:fireflutter/theme/logintheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


class googlepage extends StatefulWidget {
  const googlepage({ Key? key }) : super(key: key);

  @override
  _googlepageState createState() => _googlepageState();
}

class _googlepageState extends State<googlepage> {
   bool isselected = false;

  late FocusNode name;
  late FocusNode email;
  late FocusNode password;

  @override
  void initState() {
    super.initState();
    name = FocusNode();
    email = FocusNode();
    password = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
        body: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: logintheme.scaffoldTheme,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0, top: 10.0),
                    child: signwidget(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  signoptionwidget(),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Email",
                    style:
                        GoogleFonts.lato(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  emailwidget(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Password",
                    style:
                        GoogleFonts.lato(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  passwordwidget(),
                  SizedBox(
                    height: 10.0,
                  ),
                  submitwidget(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dont have an account?",
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: 20.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.lato(
                              color: Colors.pink, fontSize: 20.0),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  Widget signwidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        
        GradientText(
          
          "Google",
          style: GoogleFonts.lato(
              fontStyle: FontStyle.normal, color: Colors.white, fontSize: 45.0),
              colors: [
                Colors.green,
                Colors.indigo,
                Colors.teal
              ],
        ),
      ],
    );
  }

  Widget signoptionwidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Sign up with one of the following options",
            style: GoogleFonts.lato(
                color: Colors.white.withOpacity(.9), fontSize: 20),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 20.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: logintheme.iconcolor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: logintheme.border)),
                child: Center(
                    child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                )),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                width: (MediaQuery.of(context).size.width / 2) - 20.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: logintheme.iconcolor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: logintheme.border)),
                child: Center(
                    child: Icon(
                  FontAwesomeIcons.apple,
                  color: Colors.white,
                )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget namewidget() {
    return Column(
      children: [
        
          
          TextFormField(
              
              
              focusNode: name,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

              //cursorHeight: 70,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle:
                      GoogleFonts.lato(color: Colors.white70, fontSize: 20.0),
                  hintText: "enter your name",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: logintheme.bordercolor),
                    borderRadius: BorderRadius.circular(10),
                  )),
              onFieldSubmitted: (term) {
                name.unfocus();
                FocusScope.of(context).requestFocus(name);
              },
            ),
          
        
      ],
    );
  }

  Widget emailwidget() {
    return Column(
      children: [
        
          
            TextFormField(
             
              focusNode: email,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

              //cursorHeight: 70,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                       borderSide:
                          BorderSide(width: 1.0, color: logintheme.border),
                          borderRadius: BorderRadius.circular(10),
                    ),
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle:
                      GoogleFonts.lato(color: Colors.white70, fontSize: 20.0),
                  hintText: "Email",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: logintheme.bordercolor),
                    borderRadius: BorderRadius.circular(10),
                  )),
              onFieldSubmitted: (term) {
                email.unfocus();
                FocusScope.of(context).requestFocus(email);
              },
            ),
          
        
      ],
    );
  }

  Widget passwordwidget() {
    return Column(
      children: [
        
          
            TextFormField(
             
              obscureText: isselected ? false : true,
              focusNode: password,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

              //cursorHeight: 70,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                       borderSide:
                          BorderSide(width: 1.0, color: logintheme.border),
                          borderRadius: BorderRadius.circular(10),
                    ),
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.eye,
                        color: Colors.white,
                      )),
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle:
                      GoogleFonts.lato(color: Colors.white70, fontSize: 20.0),
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: logintheme.bordercolor),
                    borderRadius: BorderRadius.circular(10),
                  )),
              onFieldSubmitted: (term) {
                name.unfocus();
                FocusScope.of(context).requestFocus(name);
              },
            ),
          
        
      ],
    );
  }

  Widget submitwidget() {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 66.0,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 0, 255, 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Center(
            child: Text(
          "Submit",
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),
        )));
  }
}

