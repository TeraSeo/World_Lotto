import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/auth/service/CommentService.dart';
import 'package:lottery_kr/tab/page/auth/service/DiscussionService.dart';
import 'package:lottery_kr/tab/page/auth/service/UserService.dart';
import 'package:lottery_kr/tab/page/discussion/comment/CommentBox.dart';

class CommentsPage extends StatefulWidget {
  final String postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<Map<String, dynamic>> comments = [];
  final TextEditingController _commentController = TextEditingController();

  CommentService commentService = CommentService.instance;
  UserService userService = UserService.instance;
  DiscussionService discussionService = DiscussionService.instance;
  bool isCommentsLoading = true;

  List<dynamic> reportedUsers = [];
  bool isReportsLoading = true;
  String uid = "";

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
    }
    Future.delayed(Duration.zero).then((value) async {
      List<dynamic> commentIds = await discussionService.getComments(widget.postId);
      await commentService.getAllComments(commentIds).then((value) {
        comments = value;
        if (this.mounted) {
          setState(() {
            isCommentsLoading = false;
          });
        }
      });
    });
    userService.getReportedUsers(uid).then(
      (value) {
        reportedUsers = value;
        if (this.mounted) {
          setState(() {
            isReportsLoading = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isCommentsLoading || isReportsLoading ? Center(child: CircularProgressIndicator()) : SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(comments.length, (index) {
                    if (reportedUsers.contains(comments[index]["uid"])) {
                      return Container();
                    }
                    else {
                      return CommentCard(content: comments[index]["content"], uid: comments[index]["uid"], likes: comments[index]["likes"], commentId: comments[index]["commentId"], postId: widget.postId);
                    }
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "writeComment".tr(),
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      if (_commentController.text.length > 0) {
                        if (await discussionService.checkIsPostExists(widget.postId)) {
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          commentService.addComment(_commentController.text, uid, widget.postId).then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => CommentsPage(postId: widget.postId)),
                            );
                            _commentController.clear();
                          });
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('postDeletedMsg'.tr()),
                          ));
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
