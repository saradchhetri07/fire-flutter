import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireflutter/databasehelper/authenticate.dart';
import 'package:fireflutter/databasehelper/storage.dart';
import 'package:fireflutter/models/message_dao.dart';
import 'package:fireflutter/pages/googlepage.dart';
import 'package:fireflutter/pages/dashboard.dart';
import 'package:fireflutter/pages/loginpage.dart';
import 'package:fireflutter/theme/logintheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  var currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            lazy: false,
            create: (_)=> MessageDao()),
          ChangeNotifierProvider(create: (context) => AuthenticationService()),
          StreamProvider<User?>.value(
            value: AuthenticationService().authstatechanges,

            initialData: currentuser,

            //value: AuthenticationService().authstatechanges,
          ),
        ],
        child: const MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: login()
            //landingpage();

            ));
  }
}

class landingpage extends StatefulWidget {
  const landingpage({Key? key}) : super(key: key);

  @override
  _landingpageState createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);

    // return ChangeNotifierProvider(
    //   create: (context) => AuthenticationService(),
    //   child: StreamBuilder(
    //       stream: FirebaseAuth.instance.authStateChanges(),
    //       builder: (context, snapshot) {
    final provider = context.watch<AuthenticationService>();

    //         print(provider.isSigning);
    //         if (provider.isSigning) {
    //           return indicator();
    //         } else if (snapshot.hasData) {
    //           return dashboard();
    //         } else {
    //           return MyHomePage();
    //         }
    //       }),
    // );
    if (provider.isSigning) {
      return indicator();
    } else if (_user != null) {
      return dashboard();
    } else {
      return MyHomePage();
    }
  }

  Widget indicator() => Stack(
        fit: StackFit.expand,
        children: [
          //CustomPaint(painter: foregroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Storage newstorage = new Storage();

  bool isselected = false;

  late FocusNode name;
  late FocusNode email;
  late FocusNode password;

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

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
    // State<MyHomePage> createState() => _MyHomePageState();
    // User _user = Provider.of<User>(context);

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
                    padding: const EdgeInsets.only(left: 100.0, top: 10.0),
                    child: signwidget(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  signoptionwidget(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Name",
                    style:
                        GoogleFonts.lato(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  namewidget(),
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
                        "Already have an account?",
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: 20.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return login();
                          }));
                        },
                        child: Text(
                          "login",
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
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      // Container(
      //     height: 55.0,
      //     width: 55.0,
      //     decoration: BoxDecoration(
      //         color: logintheme.scaffoldTheme,
      //         borderRadius: BorderRadius.circular(10.0),
      //         border: Border.all(color: logintheme.iconcolor, width: 3.0),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey,
      //             offset: Offset(0.0, 1.0), //(x,y)
      //             blurRadius: 4.0,
      //           )
      //         ]),
      //     child: Center(
      //         child: Icon(
      //       FontAwesomeIcons.angleLeft,
      //       color: Colors.white,
      //     ))),
      SizedBox(
        width: 15.0,
      ),
      GradientText(
        "Teddos",
        style: GoogleFonts.lato(
            fontStyle: FontStyle.normal, color: Colors.white, fontSize: 45.0),
        colors: [
          Colors.green,
          Colors.indigo,
          Colors.teal,
        ],
      ),
    ]);
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return googlepage();
                  }));
                },
                child: Container(
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
          controller: namecontroller,
          focusNode: name,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20.0),

          //cursorHeight: 70,
          decoration: InputDecoration(
              fillColor: logintheme.iconcolor,
              contentPadding: EdgeInsets.all(20.0),
              hintStyle:
                  GoogleFonts.lato(color: Colors.white70, fontSize: 20.0),
              hintText: "enter your name",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: logintheme.border),
                borderRadius: BorderRadius.circular(10),
              ),
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
          controller: emailcontroller,
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
          controller: passwordcontroller,
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
            name.unfocus();
            FocusScope.of(context).requestFocus(name);
          },
        ),
      ],
    );
  }

  Widget submitwidget() {
    return InkWell(
      onTap: () {
        

        AuthenticationService()
            .signUp(emailcontroller.text, passwordcontroller.text);

            Map<String, String> userinfo = {
          "name": namecontroller.text,
          "email": emailcontroller.text
        };

        newstorage.uploaduserinfo(userinfo);

        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
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
