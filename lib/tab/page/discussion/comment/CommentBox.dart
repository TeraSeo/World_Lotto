import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/auth/service/CommentService.dart';
import 'package:lottery_kr/tab/page/auth/service/DiscussionService.dart';
import 'package:lottery_kr/tab/page/auth/service/UserService.dart';
import 'package:translator/translator.dart';

class CommentCard extends StatefulWidget {
  final String content;
  final String uid;
  final List<dynamic> likes;
  final String commentId;
  final String postId;
  const CommentCard({super.key, required this.content, required this.uid, required this.likes, required this.commentId, required this.postId});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {

  UserService userService = UserService.instance;
  CommentService commentService = CommentService.instance;
  GoogleTranslator googleTranslator = GoogleTranslator();
  DiscussionService discussionService = DiscussionService.instance;

  String username = "";
  String editingContentTxt = "";
  String content = "";

  bool isNameLoading = true;

  bool isEditing = false;
  bool isDeleted = false;

  String currentUid = FirebaseAuth.instance.currentUser!.uid;

  int commentLikes = 0;
  bool isLiked = false;

  late TextEditingController textEditingController;

  String localeCode = "";
  String translatedText = "";
  bool isTranslated = false;

  bool isReported = false;

  @override
  void initState() {
    super.initState();
    commentLikes = widget.likes.length; 
    isLiked = widget.likes.contains(currentUid);
    content = widget.content;
    userService.getUserName(widget.uid).then((value) {
      if (this.mounted) {
        if (value == "") {
          setState(() {
            username = "Unknown User";
          });
        }
        else {
          setState(() {
            username = value;
          });
        }
        setState(() {
          isNameLoading = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Locale currentLocale = context.locale;
    localeCode = currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return isDeleted || isReported ? Container() : Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045, vertical: MediaQuery.of(context).size.height * 0.022),
      child: isNameLoading ? Center(child: CircularProgressIndicator()) : Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, color: Colors.grey[800]),
            radius: 20,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username, style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.0165, color: Colors.white, fontWeight: FontWeight.bold)),
                isEditing ?
                TextField(
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: "editComment".tr(),
                  ),
                  onSubmitted: (value) {
                    if (this.mounted) {
                      setState(() {
                        editingContentTxt = value;
                      });
                    }
                    showEditDialog();
                  },
                ) :
                (isTranslated && translatedText != "") ?
                Text(translatedText, style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.0165, color: Colors.white)) :
                Text(content, style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.0165, color: Colors.white)),
                SizedBox(height: 8),
                Row(
                  children: [
                    // Text("reply", style: TextStyle(fontSize: 13, color: Colors.grey)),
                    // SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        if (localeCode != "" && !isTranslated) {
                          if (translatedText == "") {
                            googleTranslator.translate(content, to: "ko").then((value) {
                              if (this.mounted) {
                                setState(() {
                                  translatedText = value.toString();
                                });
                              }
                            });
                          }
                          if (this.mounted) {
                            setState(() {
                              isTranslated = true;
                            });
                          }
                        }
                        else {
                          if (this.mounted) {
                            setState(() {
                              isTranslated = false;
                            });
                          }
                        }
                      },
                      child: Text("seeTranslation".tr(), style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.0155, color: Colors.grey)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
            Column(
              children: [
                isLiked ? GestureDetector(
                  child: Icon(Icons.favorite, color: Colors.red, size: MediaQuery.of(context).size.height * 0.028),
                  onTap: () async {
                    if (await commentService.checkIsCommentExists(widget.commentId)) {
                      commentService.removeLike(widget.commentId, currentUid).then((value) {
                        if (this.mounted) {
                          setState(() {
                            commentLikes -= 1;
                            isLiked = false;
                          });
                        }
                      });
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('commentNotExists'.tr()),
                      ));
                    }
                  },
                ) :
                GestureDetector(
                  child: Icon(Icons.favorite_outline, color: Colors.white, size: MediaQuery.of(context).size.height * 0.028,),
                  onTap: () async {
                    if (await commentService.checkIsCommentExists(widget.commentId)) {
                      commentService.addLike(widget.commentId, currentUid).then((value) {
                        if (this.mounted) {
                          setState(() {
                            commentLikes += 1;
                            isLiked = true;
                          });
                        }
                      });
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('commentNotExists'.tr()),
                    ));
                    }
                  },
                ),
                commentLikes == 0 ?
                Text("", style: TextStyle(color: Colors.white)) :
                Text(commentLikes.toString(), style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.015))
              ],
            ),
             SizedBox(width: 10),
             Column(
                children: [
                  currentUid == widget.uid ?
                  GestureDetector(
                    child: Icon(Icons.more_vert, color: Colors.white, size: MediaQuery.of(context).size.height * 0.028),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0)
                          )
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isEditing ?
                                ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("cancelEditing".tr()),
                                  onTap: () {
                                    Navigator.pop(context); 
                                    if (this.mounted) {
                                      setState(() {
                                        isEditing = false;
                                      });
                                    }
                                  },
                                ) :
                                ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("editComment".tr()),
                                  onTap: () {
                                    Navigator.pop(context); 
                                    if (this.mounted) {
                                      setState(() {
                                        textEditingController = TextEditingController(text: content);
                                        editingContentTxt = content;
                                        isEditing = true;
                                      });
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.remove_circle),
                                  title: Text("removeComment".tr()),
                                  onTap: () {
                                    showRemoveDialog();
                                  },
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
                              ],
                            ),
                          );
                        }
                      );
                    },
                  ) :
                  GestureDetector(
                    child: Icon(Icons.report_gmailerrorred, color: Colors.white, size: MediaQuery.of(context).size.height * 0.028,),
                    onTap: () {
                      showReportDialog();
                    },
                  ),
                  Text("", style: TextStyle(color: Colors.white))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("confirmEdit".tr()),
          content: Text("askCommetUpdate".tr()),
          actions: <Widget>[
            TextButton(
              child: Text("cancel".tr()),
              onPressed: () {
                Navigator.of(context).pop();
                if (this.mounted) {
                  setState(() {
                    isEditing = false;
                  });
                }
              },
            ),
            TextButton(
              child: Text("confirm".tr()),
              onPressed: () async {
                if (editingContentTxt != content) {
                  if (await discussionService.checkIsPostExists(widget.postId)) {
                    Navigator.of(context).pop();
                    commentService.editComment(widget.commentId, editingContentTxt);
                    if (this.mounted) {
                      setState(() {
                        content = editingContentTxt;
                        translatedText = "";
                        isEditing = false;
                      });
                    }
                  }
                  else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('postDeletedMsg'.tr()),
                          ));
                    if (this.mounted) {
                    setState(() {
                      isEditing = false;
                    });
                  }
                  }
                }
                else {
                  Navigator.of(context).pop();
                  if (this.mounted) {
                    setState(() {
                      isEditing = false;
                    });
                  }
                }
              },
            ),
          ],
        );
    });
  }

  void showRemoveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("confirmRemovement".tr()),
          content: Text("askRemoveComment".tr()),
          actions: <Widget>[
            TextButton(
              child: Text("cancel".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("confirm".tr()),
              onPressed: () async {
                if (await discussionService.checkIsPostExists(widget.postId)) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  await commentService.removeComment(widget.commentId, widget.postId, widget.uid).then(
                    (value) {
                      if (this.mounted) {
                        setState(() {
                          isDeleted = true;
                        });
                      }
                    },
                  );
                }
                else {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  if (this.mounted) {
                    setState(() {
                      isDeleted = true;
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('postDeletedMsg'.tr()),
                  ));
                }
              },
            ),
          ],
        );
    });
  }
  
  void showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("confrimReport".tr()),
          content: Text("askReportComment".tr()),
          actions: <Widget>[
            TextButton(
              child: Text("cancel".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("confirm".tr()),
              onPressed: () async {
                if (await commentService.checkIsCommentExists(widget.commentId)) {
                  Navigator.of(context).pop();
                  if (this.mounted) {
                    setState(() {
                      isReported = true;
                    });
                  }
                  userService.addUserReport(currentUid, widget.uid).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('reportSucceeded'.tr()),
                      )
                    );
                  });
                }
                else {
                  Navigator.of(context).pop();
                  if (this.mounted) {
                    setState(() {
                      isReported = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('commentNotExists'.tr()),
                    ));
                  }
                }
              },
            ),
          ],
        );
    });
  }

}