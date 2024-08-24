import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery_kr/tab/page/auth/service/DiscussionService.dart';
import 'package:lottery_kr/tab/page/auth/service/StorageService.dart';
import 'package:lottery_kr/tab/page/discussion/DiscussionPage.dart';
import 'package:lottery_kr/tab/page/discussion/image/ImagePickerService.dart';

class EditDiscussionPage extends StatefulWidget {
  final String postId;
  final String category;
  final String content;
  final List<dynamic> images;
  const EditDiscussionPage({super.key, required this.postId, required this.category, required this.content, required this.images});

  @override
  State<EditDiscussionPage> createState() => _EditDiscussionPageState();
}

class _EditDiscussionPageState extends State<EditDiscussionPage> {
  ImagePickerService imagePickerService = ImagePickerService.instance;
  DiscussionService discussionService = DiscussionService.instance;
  StorageService storageService = StorageService.instance;

  TextEditingController contentController = TextEditingController();
  String content = "";
  String? category;
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

  @override
  void initState() {
    super.initState();
    category = widget.category;
    contentController.text = widget.content;
    content = widget.content;
    imageFiles = widget.images;
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  List<XFile> croppedFiles = [];
  List<dynamic> imageFiles = [];
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
                                  children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(imageFiles.length, (index) {
                                          return Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Image.network(
                                                    imageFiles[index], 
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
                                                          imageFiles.removeAt(index);
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
                                      Row(
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
                                      )
                                    ],
                                  )]
                                ),
                              )
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        getLabel(title: "Lottery"),
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
                       
                        getLabel(title: "Caption"),
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
                              return "write caption";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(hintText: "caption", labelStyle: TextStyle(color: Colors.black), prefixIcon: Icon(Icons.description), enabledBorder: myinputborder(context), focusedBorder: myfocusborder(context), prefixIconColor: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
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
                                  discussionService.editDicussionData(widget.postId, uId, content, category!, croppedFiles, imageFiles).then((value) {
                                    print("to delete: " + value.length.toString());
                                    storageService.deleteSpecificPostImages(uId, widget.postId, value);
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
                            child: Text("Edit", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.017)),
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