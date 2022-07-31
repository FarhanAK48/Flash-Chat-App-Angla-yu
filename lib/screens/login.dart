import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/screens/register.dart';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/firebase_services.dart';
import '../widgets/button_code.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypepwdC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;

  bool pwd = true;
  void dispose() {
    emailCon.dispose();
    password.dispose();
    super.dispose();
  }

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

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      String? accountstatus =
          await FirebaseServices.signInAccount(emailCon.text, password.text);
      if (accountstatus != null) {
        ecoDilogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      }
    }
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
                    'Welcome \n Please Login First',
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
                              contrl: emailCon,
                              hintxt: 'Email...',
                              // validate: (v) {
                              //   if (v!.isEmpty ||
                              //       !v.contains("@") ||
                              //       !v.contains("com")) {
                              //     return 'Email is badly formated';
                              //   }
                              //   return null.toString();
                              // },
                              icon: Icon(Icons.mail),
                              textinputAction: TextInputAction.next,
                            ),
                            EcoTextField(
                                contrl: password,
                                obsecure: pwd,
                                hintxt: 'Enter Password',
                                // validate: (v) {
                                //   if (v!.isEmpty) {
                                //     return "Password should not be empty";
                                //   }
                                //   return null.toString();
                                // },
                                icon: IconButton(
                                  icon: pwd
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      pwd = !pwd;
                                    });
                                  },
                                )),
                            EcoButton(
                              txt: 'LOGIN',
                              isLoading: formStateLoading,
                              isloginButton: true,
                              onPress: () {
                                login();
                              },
                            ),
                          ],
                        )),
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  EcoButton(
                      txt: 'CREATE NEW ACCOUNT',
                      isloginButton: false,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
