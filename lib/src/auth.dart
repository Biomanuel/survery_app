import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../apptheme.dart';

class AuthDialog extends StatefulWidget {
  final Function callback;
  final bool init;

  AuthDialog({this.init = false, this.callback});

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  String name;
  String lga;
  String email;
  String password = "surveyAgent!23";
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    // await Firebase.initializeApp().whenComplete(() {
    //   print("Firebase Initialization completed");
    //   // setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.init)
      return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          constraints: BoxConstraints(minHeight: 100, minWidth: 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "It's your first time!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Please, fill your details below to register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  autofocus: true,
                  autovalidate: true,
                  validator: (input) =>
                      input.isValidEmail() ? null : "Check your email",
                  style: TextStyle(color: Colors.black),
                  decoration: App.kAuthTextFieldDecoration
                      .copyWith(hintText: "Enter your email"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    autofocus: true,
                    autovalidate: true,
                    style: TextStyle(color: Colors.black),
                    decoration: App.kAuthTextFieldDecoration
                        .copyWith(hintText: "Enter your name"),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    lga = value;
                  },
                  autofocus: true,
                  autovalidate: true,
                  style: TextStyle(color: Colors.black),
                  decoration: App.kAuthTextFieldDecoration
                      .copyWith(hintText: "Enter your LGA"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber[700],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            bool confirmed = await confirmUser();
                            if (confirmed) {
                              widget.callback(confirmed);
                              // Navigator.pop(context);
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFF),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    else
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
  }

  Future<bool> confirmUser() async {
    // var email = "tony@starkindustries.com";
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    setState(() {
      showSpinner = true;
    });
    if (name == null || name.isEmpty || lga == null || lga.isEmpty) {
      Fluttertoast.showToast(msg: "Please, Enter your details");
      showSpinner = false;
      setState(() {});
      return false;
    } else {
      setState(() {
        App.userDetail = name + " - " + lga;
      });
    }
    // if (emailValid.hasMatch(email)) {
    //   Fluttertoast.showToast(msg: "Please, Enter a valid email Address");
    //   showSpinner = false;
    //   setState(() {});
    //   return false;
    // }
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        Fluttertoast.showToast(msg: "Successful! \n Thank You!");
        // Navigator.pushNamed(context, ChatScreen.id);
        setState(() {
          showSpinner = false;
        });
        App.storeCurrentUserId(email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      try {
        final user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (user != null) {
          Fluttertoast.showToast(msg: "Successful! \n Thank You!");
          App.storeCurrentUserId(email);
          // Navigator.pushNamed(context, ChatScreen.id);
          setState(() {
            showSpinner = false;
          });
          return true;
        } else {
          return false;
        }
      } catch (e1) {
        print(e1);
        setState(() {
          showSpinner = false;
        });
        Fluttertoast.showToast(
            msg: "An Error Occurred! \n Please, check your Internet connection",
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (e2) {
      setState(() {
        showSpinner = false;
      });
      Fluttertoast.showToast(
          msg: "An Error Occurred! \n Please, check your Internet connection",
          toastLength: Toast.LENGTH_LONG);
      print(e2);
      return false;
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
