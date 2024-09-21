import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery_kr/service/DiscussionService.dart';
import 'package:lottery_kr/service/UserService.dart';
import 'package:lottery_kr/page/discussion/DiscussionPage.dart';
import 'package:lottery_kr/page/discussion/image/ImagePickerService.dart';

class AddDiscussion extends StatefulWidget {
  const AddDiscussion({super.key});

  @override
  State<AddDiscussion> createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {

  ImagePickerService imagePickerService = ImagePickerService.instance;
  DiscussionService discussionService = DiscussionService.instance;
  UserService userService = UserService.instance;

  TextEditingController contentController = TextEditingController();
  String content = "";
  String category = "Powerball";
  List<String>? items = [
    "Powerball",
    "MegaMillion",
    "EuroMillions",
    "EuroJackpot",
    "UK Lotto",
    "La Primitiva",
    "El Gordo(5/54)",
    "SuperEnalotto",
    "Australia Powerball",
    "Lotto 6/45",
    "Lotto 6",
    "Lotto 7"
  ];

  final _formKey = GlobalKey<FormState>();

  List<XFile> croppedFiles = [];
  bool isImagesLoading = false;
  bool isPostLoading = false;

  Future<bool> _onWillPop() async {
    return !isPostLoading;
  }

  @override
  Widget build(BuildContext context) {
    return isImagesLoading? const Center(child: CircularProgressIndicator()) : GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.065,
                              width: MediaQuery.of(context).size.height * 0.065,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.white, 
                                  width: 2, 
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  if (this.mounted) {
                                    setState(() {
                                      isImagesLoading = true;
                                    });
                                  }
                                    imagePickerService.pickCropImage(cropAspectRatio: const CropAspectRatio(ratioX: 10, ratioY: 12), imageSource: ImageSource.gallery, context: context).then((value) {
                                      if (this.mounted) {
                                        setState(() {
                                          if (value == null) {
                                            isImagesLoading = false;
                                          }
                                          else {
                                            croppedFiles = value;
                                            if (croppedFiles.length > 8) {
                                              for (int i = 8; i < croppedFiles.length; i++) {
                                                croppedFiles.removeAt(i);
                                              }
                                            }
                                            isImagesLoading = false;
                                          }
                                        });
                                      }
                                    });
                                }, 
                                icon: const Icon(Icons.camera_enhance, color: Colors.white)), 
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(croppedFiles.length, (index) {
                                    return Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Image.file(
                                              File(croppedFiles[index].path),
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context).size.height * 0.065,
                                              width: MediaQuery.of(context).size.height * 0.05,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    croppedFiles.removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.close, size: 16, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20)
                                      ],
                                    );
                                  }),
                                ),
                              )
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(croppedFiles.length.toString() + "/8"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        getLabel(title: "lottery".tr()),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: MediaQuery.of(context).size.height * 0.002)
                          ),
                          child: DropdownButton<String>(
                            value: category,
                            isExpanded: true,
                            items: items!.map(buildMenuItem).toList(),
                            onChanged: (value) {
                              if (this.mounted) {
                                setState(() {
                                  category = value!;
                                });
                              }
                            }
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                       
                        getLabel(title: "caption".tr()),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextFormField(
                          maxLength: 500,
                          maxLines: 9,
                          style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018),
                          controller: contentController,
                          onChanged: (val) {
                            content = val;
                          },
                          validator: (value) {
                            if (value!.length <= 0) {
                              return "writeCaption".tr();
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(hintText: "caption".tr(), labelStyle: TextStyle(color: Colors.black), prefixIcon: Icon(Icons.description), enabledBorder: myinputborder(context), focusedBorder: myfocusborder(context), prefixIconColor: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text("postViolation".tr(), textAlign: TextAlign.center, style: TextStyle(color: const Color.fromARGB(255, 91, 90, 90))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        isPostLoading ? const Center(child: CircularProgressIndicator()) : Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: ElevatedButton(
                            onPressed: () async{
                              try {
                                if (_formKey.currentState!.validate()) {
                                  if (this.mounted) {
                                    setState(() {
                                      isPostLoading = true;
                                    });
                                  }
                                  String uId = FirebaseAuth.instance.currentUser!.uid;
                                  discussionService.addDiscussionData(uId, content, category, croppedFiles).then((value) {
                                    userService.addPost(value, uId);
                                    if (this.mounted) {
                                      setState(() {
                                        isPostLoading = false;
                                      });
                                    }
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DiscussionPage()),
                                    );
                                  });
                                }
                              } catch(e) {
                                print(e.toString());
                              }
                            },
                            child: Text("post".tr(), style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.017)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.black,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              )
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ))
    );
  }

  Widget getLabel({required String title}) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            title, style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontWeight: FontWeight.w600
            )
          )
        ]
      );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
    )
  );

  OutlineInputBorder myinputborder(BuildContext context){ 
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color: Colors.black,
          width: MediaQuery.of(context).size.width * 0.005, 
        )
    );
  }

  OutlineInputBorder myfocusborder(BuildContext context){
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black,
          width: MediaQuery.of(context).size.height * 0.003,
        )
    );
  }
}