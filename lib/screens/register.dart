import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/button_code.dart';
import '../widgets/text_field.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController retypepwdC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isReTypePassword = true;
  bool formStateLoading = false;
  // void dispose() {
  //   emailC.dispose();
  //   passwordC.dispose();
  //   retypepwdC.dispose();
  //   super.dispose();
  // }

  Future<void> ecoDilogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                txt: 'Close',
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<void> addData() async {
    // User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('User').add({
      'Email': emailC.text,
      'Password': passwordC.text,
    });
  }

  void AddData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('UserId').doc(user?.uid).set({
      'Email': emailC.text,
      'Password': passwordC.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100 * 5),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome \n Please Create Your Account',
                    textAlign: TextAlign.center,
                    style: boldStyle,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 15,
                  ),
                  Column(children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            EcoTextField(
                              // validate: (v) {
                              //   if (v!.isEmpty ||
                              //       !v.contains("@") ||
                              //       !v.contains("com")) {
                              //     return "Email is badly formated";
                              //   }
                              //   return null.toString();
                              // },
                              contrl: emailC,
                              textinputAction: TextInputAction.next,
                              hintxt: 'Email...',
                              icon: Icon(Icons.email),
                            ),
                            EcoTextField(
                                obsecure: isPassword,
                                contrl: passwordC,
                                // validate: (v) {
                                //   if (v!.isEmpty) {
                                //     return "Password should not be empty";
                                //   }
                                //   return null.toString();
                                // },
                                textinputAction: TextInputAction.next,
                                hintxt: 'Enter Password',
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPassword = !isPassword;
                                    });
                                  },
                                  icon: isPassword
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                )),
                            EcoTextField(
                              obsecure: isReTypePassword,
                              // validate: (v) {
                              //   if (v!.isEmpty) {
                              //     return "Password should not be empty";
                              //   }
                              //   return null.toString();
                              // },
                              icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isReTypePassword = !isReTypePassword;
                                  });
                                },
                                icon: isReTypePassword
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                              contrl: retypepwdC,
                              hintxt: 'Retype Password',
                            ),
                            EcoButton(
                              onPress: () async {
                                // addData();
                                AddData();
                                //AdData();
                                try {
                                  var newUser = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailC.text,
                                          password: passwordC.text);

                                  if (newUser != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen()));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                // Navigator.pushNamed(context, login())
                                // User? user =
                                //     await FirebaseAuth.instance.currentUser;
                                // FirebaseFirestore.instance
                                //     .collection('UserUId')
                                //     .doc(user?.uid)
                                //     .set({
                                //   'Email': emailC.text,
                                //   'Password': passwordC.text,
                                // });
                                //     .then((value) async {
                                //   SharedPreferences preferences =
                                //       await SharedPreferences.getInstance();
                                //   preferences.setString('Email', emailC.text);
                                // });
                              },
                              isLoading: formStateLoading,
                              txt: 'SIGNUP',
                              isloginButton: true,
                            ),
                          ],
                        )),
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  EcoButton(
                    txt: 'BACK TO LOGIN',
                    isloginButton: false,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
