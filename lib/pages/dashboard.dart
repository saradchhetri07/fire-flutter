import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/databasehelper/authenticate.dart';
import 'package:fireflutter/databasehelper/storage.dart';
import 'package:fireflutter/models/message.dart';
import 'package:fireflutter/models/message_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Widget userlist() {
//   return ListView.builder(

//     itemBuilder: (BuildContext context, index) {
//     return searchTile();
//   });
// }

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  TextEditingController usersearch = TextEditingController();
  Storage newstorage = Storage();

  QuerySnapshot? newsnapshot;

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Column(
    //       children: [
    //         //container for searching users
    //         Padding(
    //           padding:
    //               const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
    //           child: Container(
    //             height: 60,
    //             width: MediaQuery.of(context).size.width,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 boxShadow: [BoxShadow(blurRadius: 8.0)]),
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 8.0),
    //               child: TextFormField(
    //                   controller: usersearch,
    //                   decoration: InputDecoration(
    //                       border: InputBorder.none,
    //                       hintText: 'search user',
    //                       suffixIcon: iconWidget())),
    //             ),
    //           ),
    //         ),

    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         ElevatedButton(
    //             onPressed: () {
    //              newsnapshot = newstorage.searchuser(usersearch.text);
    //               print(newsnapshot!.docs.data());
    //             },
    //             child: Text("user"))
    //       ],
    //     ),
    //   ),
    // );

    TextEditingController chatcontroller = new TextEditingController();
    MessageDao messageDao = MessageDao();
    Message message = Message();
    ScrollController _scrollController = new ScrollController();

    AuthenticationService newuser = AuthenticationService();

    final Daoprovider = Provider.of<MessageDao>(context, listen: false);

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      chatcontroller.dispose();
      super.dispose();
    }

    Widget chatText = new TextFormField(
      controller: chatcontroller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 5,
      decoration: new InputDecoration(
        hintText: "type your message",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(width: 5.0, style: BorderStyle.solid),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val!.length == 0) {
          return "Email cannot be empty";
        } else {
          return null;
        }
      },
    );
//     Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
//   // 1
//   final message = Message.fromSnapshot(snapshot);
//   // 2
//   return MessageWidget(
//     message.text,
//     message.date,
//     message.email
//   );
// }
    // Widget _buildContext(
    //     BuildContext context, List<DocumentSnapshot>? snapshot) {
    //   return ListView(
    //     controller: _scrollController,
    //      physics: const BouncingScrollPhysics(),
    //      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    //   );
    // }

    // Widget _buildchatList = new StreamBuilder(
    //     stream: Daoprovider.getmessageStream(),
    //     builder: (context, snapshot) {
    //       return _buildContext(context, snapshot.data!.docs);
    //     });

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black87),
            ),
          ),
         // _buildchatList,
          Positioned(
            bottom: 1.0,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black87),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.add),
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Container(
                      height: 60.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: chatText),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      String text = chatcontroller.text;
                      DateTime date = DateTime.now();
                      //

                      String? email = newuser.getuser()!.email;

                      Message message =
                          new Message(text: text, date: date, email: email);

                      messageDao.saveMessage(message);
                      chatcontroller.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  // Widget iconWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Container(
  //       height: 40.0,
  //       width: 40.0,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         gradient: LinearGradient(colors: [
  //           Colors.black12,
  //           Colors.black,
  //         ]),
  //         //borderRadius: BorderRadius.circular(40.0)
  //       ),
  //       child: Icon(
  //         Icons.search,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

}
