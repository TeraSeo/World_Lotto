import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/Home.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/tab/page/auth/RegisterPage.dart';
import 'package:lottery_kr/tab/page/auth/service/AuthService.dart';
import 'package:lottery_kr/tab/page/auth/service/UserService.dart';
import 'package:lottery_kr/tab/page/discussion/DiscussionPage.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  AuthService authService = AuthService.instance;
  UserService userService = UserService.instance;
  HelperFunctions helperFunctions = HelperFunctions();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    double verticalPadding = MediaQuery.of(context).size.height * 0.04;
    double borderCircular = MediaQuery.of(context).size.height * 0.035;
    double padding = MediaQuery.of(context).size.height * 0.027;
    double sizedBox = MediaQuery.of(context).size.height * 0.04;
    double signInBtnHeight = MediaQuery.of(context).size.height * 0.05;

    return 
      WillPopScope(
        onWillPop: () async => !isLoading,
        child: 
      Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.lightBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              )
            ),
            child: 
            isLoading? Center(child: CircularProgressIndicator()) :
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding, horizontal: verticalPadding / 3 * 2
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Home()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalPadding / 4 * 5,
                          fontWeight: FontWeight.w800
                        ),),
                        SizedBox(
                          height: verticalPadding / 4,
                        ),
                        Text(
                          "Enter to a beautiful world",
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalPadding / 1.7,
                          fontWeight: FontWeight.w300
                        ),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderCircular),
                        topRight: Radius.circular(borderCircular)
                      )
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding:  EdgeInsets.all(padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "email".tr(), 
                                  prefixIcon : Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                validator: (val) {
                                  return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=>^_'{|}~]+@[a-zA-Z]+")
                                      .hasMatch(val!) ? null : "emailNotValid".tr();
                                },
                              ),
                              SizedBox(height: sizedBox),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "password".tr(),
                                  prefixIcon : Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "passwordNotValid".tr();
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val){
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: sizedBox * 2.2,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: signInBtnHeight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderCircular)
                                    )
                                  ),
                                  child: Text(
                                    "login".tr(),
                                    style: TextStyle(color: Colors.white, fontSize: borderCircular / 2),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      login(email, password);
                                    }
                                  },
                                )
                              ),
                              SizedBox(height: borderCircular / 2 * 1.5),
                              Text.rich(
                                TextSpan(
                                  text: "newUser".tr() + " ",
                                  style: TextStyle(color: Colors.black, fontSize: borderCircular / 8 * 4),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "goToRegister".tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                                        );
                                      }
                                    ),
                                  ]
                                )
                              ),
                              SizedBox(
                                height: sizedBox * 1.2,
                              ),
                              Container(
                                width: double.infinity,
                                child: SignInButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(borderCircular)
                                ),
                                Buttons.google,
                                text: "signUpWithGoogle".tr(),
                                onPressed: () {
                                  if (this.mounted) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  }
                                  authService.signInWithGoogle().then((value) async {
                                    if (value != null) {
                                      String email = "Unknown";
                                      String name = "Unknown";
                                      if (value.user!.email != "") email = value.user!.email!;
                                      if (value.user!.displayName != "") name = value.user!.displayName!;
                                      if (value.user!.uid != "") {
                                        if (!await userService.isUserExists(value.user!.uid)) {
                                          await userService.savingeUserData(name, email, value.user!.uid);
                                            if (this.mounted) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                            }
                                          }
                                          else {
                                            if (this.mounted) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                            }
                                        }
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const DiscussionPage()),
                                        );
                                      }
                                    }
                                    else {
                                      if (this.mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('loginFailed'.tr()),
                                        )
                                      );
                                    }
                                  });
                                },
                              ),
                              ),
                              Container(
                                width: double.infinity,
                                child: SignInButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(borderCircular)
                                  ),
                                  Buttons.appleDark,
                                  text: "signUpWithApple".tr(),
                                  onPressed: () {
                                    if (this.mounted) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                    authService.signInWithApple().then((value) async {
                                      if (value != null) {
                                        String email = "Unknown";
                                        String name = "Unknown";
                                        if (value.user!.email != null) email = value.user!.email!;
                                        if (value.user!.displayName != null) name = value.user!.displayName!;
                                        if (value.user!.uid != "") {
                                          if (await userService.isUserExists(value.user!.uid)) {
                                            await userService.savingeUserData(name, email, value.user!.uid);
                                            if (this.mounted) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                            }
                                          }
                                          else {
                                            if (this.mounted) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                            }
                                          }
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const DiscussionPage()),
                                          );
                                        }
                                      }
                                      else {
                                        if (this.mounted) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('loginFailed'.tr()),
                                          )
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: sizedBox * 1,
                              ),
                            ],
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
      ))
    );
  }

  login(String email, String password) {
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
    authService.loginWithUserNameandPassword(email, password).then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DiscussionPage()),
        );
        if (this.mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('email or password is not correct'),
          )
        );
        if (this.mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }
}
