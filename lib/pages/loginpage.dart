import 'package:fireflutter/databasehelper/authenticate.dart';
import 'package:fireflutter/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fireflutter/theme/logintheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  bool isselected = false;

  late FocusNode name;
  late FocusNode email;
  late FocusNode password;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
    final provider = context.watch<AuthenticationService>();
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
                    padding: const EdgeInsets.only(left: 0.0, top: 20.0),
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
                  submitwidget(context),
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
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              height: 55.0,
              width: 55.0,
              decoration: BoxDecoration(
                  color: logintheme.scaffoldTheme,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: logintheme.iconcolor, width: 3.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 4.0,
                    )
                  ]),
              child: Center(
                  child: Icon(
                FontAwesomeIcons.angleLeft,
                color: Colors.white,
              ))),
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          "Log in",
          style: GoogleFonts.lato(
              fontStyle: FontStyle.normal, color: Colors.white, fontSize: 45.0),
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

  Widget emailwidget() {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          focusNode: email,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

          //cursorHeight: 70,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: logintheme.border),
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
          controller: passwordController,
          obscureText: isselected ? false : true,
          focusNode: password,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

          //cursorHeight: 70,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: logintheme.border),
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
            password.unfocus();
            FocusScope.of(context).requestFocus(name);
          },
        ),
      ],
    );
  }

  Widget submitwidget(BuildContext context) {
    return InkWell(
      onTap: () {
        // AuthenticationService()
        //     .signIn(emailController.text, passwordController.text);
        // emailController.clear();
        // passwordController.clear();
        setState(() {
          
          AuthenticationService().isSigning = true;
        });
        
        AuthenticationService()
            .signIn(emailController.text, passwordController.text);
        emailController.clear();
        passwordController.clear();

       

        

        


        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return landingpage();
        }));
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 66.0,
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 0, 255, 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
              child: Text(
            "Submit",
            style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),
          ))),
    );
  }
}
