import 'package:easy_localization/easy_localization.dart';
// import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/page/auth/LoginPage.dart';
import 'package:lottery_kr/service/AuthService.dart';
import 'package:lottery_kr/page/discussion/DiscussionPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();
  final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

  String name = "";
  String email = "";
  String password = "";
  String passwordCheck = "";
  bool isEmailValid = false;

  AuthService authService = AuthService.instance;
  HelperFunctions helperFunctions = HelperFunctions();

  bool isOtpSent = false; 
  bool isOtpVerified = false;
  String otpCode = "";

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double verticalPadding = MediaQuery.of(context).size.height * 0.04;
    double borderCircular = MediaQuery.of(context).size.height * 0.035;
    double padding = MediaQuery.of(context).size.height * 0.027;
    double sizedBox = MediaQuery.of(context).size.height * 0.03;
    double signInBtnHeight = MediaQuery.of(context).size.height * 0.04;

    return 
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            "Register", 
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
                          ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
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
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                maxLength: 20,
                                decoration: InputDecoration(
                                  labelText: "accountName".tr(),
                                  prefixIcon : Icon(
                                    Icons.account_box,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "accountNotValid".tr();
                                  }
                                },
                                onChanged: (val){
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              SizedBox(height: sizedBox),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
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
                                            isEmailValid = emailRegExp.hasMatch(email);
                                          });
                                        },
                                        validator: (val) {
                                          return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=>^_'{|}~]+@[a-zA-Z]+")
                                              .hasMatch(val!) ? null : "emailNotValid".tr();
                                        },
                                      ),
                                    ),
                                    // SizedBox(width: 8),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width * 0.15,
                                    //   height: 36,
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), 
                                    //       backgroundColor: isEmailValid ? Theme.of(context).primaryColor : Colors.grey,
                                    //       elevation: 0,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(0),
                                    //       ),
                                    //     ),
                                    //     child: Text(
                                    //       "verify".tr(),
                                    //       style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.03),
                                    //     ),
                                    //     onPressed: () async {
                                    //       if (emailRegExp.hasMatch(email)) {
                                    //         sendOtp(email);
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              isOtpSent ? 
                              Container(
                                padding: EdgeInsets.symmetric(vertical: verticalPadding * 0.8, horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded( // Adding Expanded to prevent overflow
                                      child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "otp".tr(),
                                        prefixIcon : Icon(
                                          Icons.numbers,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      ),
                                      onChanged: (val){
                                        setState(() {
                                          otpCode = val;
                                        });
                                      },
                                    )),
                                    SizedBox(width: 8.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height: 36,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), 
                                          backgroundColor: isOtpVerified ? Colors.green : Theme.of(context).primaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                        child: Text(
                                          "confirm".tr(),
                                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.03),
                                        ),
                                        onPressed: () async {
                                          // checkOtp(otpCode);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ): 
                              Container(),
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
                                height: sizedBox,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "passwordCheck".tr(),
                                  prefixIcon : Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                                validator: (val) {
                                  if (password != passwordCheck) {
                                    return "passwordNotSame".tr();
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val){
                                  setState(() {
                                    passwordCheck = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: sizedBox * 1,
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
                                    "register".tr(),
                                    style: TextStyle(color: Colors.white, fontSize: borderCircular / 2),
                                  ),
                                  onPressed: () {
                                    // if (isOtpVerified) 
                                    register();
                                  },
                                )
                              ),
                              SizedBox(height: sizedBox / 2),
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: borderCircular / 8  * 4),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "goBackLogin".tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline  
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginPage()),
                                        );
                                      }
                                    ),
                                  ]
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      )
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      )
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      await authService.registerUserWithEmailandPassword(name, email, password)
        .then((value) async {
        if (value == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiscussionPage()),
          );
        } else {
          setState(() {
            showRegisterFailedSnackbar();
          });
        }
      });
    }
  }

  // sendOtp(String email) async {
  //   if (this.mounted) {
  //     setState(() {
  //       isOtpVerified = false;
  //     });
  //   }
  //   print(email);
  //   bool result = await EmailOTP.sendOTP(email: email);
  //   if (result) {
  //     if (this.mounted) {
  //       setState(() {
  //         isOtpSent = true;
  //       });
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("otpSent".tr())));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("otpNotSent".tr())));
  //   }
  // }

  // checkOtp(code) {
  //   if (this.mounted) {
  //     setState(() {
  //       isOtpVerified = EmailOTP.verifyOTP(otp: code);
  //     });
  //   }
  // }

  showRegisterFailedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('emailExists'.tr(), style: TextStyle(color: Colors.red)),
    ));
  }
}