import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/service/DiscussionService.dart';
import 'package:lottery_kr/service/UserService.dart';
import 'package:lottery_kr/page/discussion/DiscussionCard.dart';
import 'package:lottery_kr/widget/Widget.dart';

class ShowLikedPosts extends StatefulWidget {
  const ShowLikedPosts({super.key});

  @override
  State<ShowLikedPosts> createState() => _ShowLikedPostsState();
}

class _ShowLikedPostsState extends State<ShowLikedPosts> {

  UserService userService = UserService.instance;
  CommonWidget common = CommonWidget.instance;
  DiscussionService discussionService = DiscussionService.instance;
  ScrollController _scrollController = ScrollController();

  List<dynamic> postdIds = [];
  List<Map<String, dynamic>> likedPosts = [];
  bool isLikedLoading = true;
  bool isPostsLoading = true;

  String uid = "";

  String category = "All";
  List<String> categoryList = [
    "All",
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
    if (FirebaseAuth.instance.currentUser != null) {
      if (this.mounted) {
        setState(() {
          uid = FirebaseAuth.instance.currentUser!.uid;
        });
      }
    }
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      var likedPostIds = await userService.getLikedPosts(uid);
      if (!this.mounted) return;

      setState(() {
        postdIds = likedPostIds; // Assuming postdIds is declared somewhere in your class
        isLikedLoading = false;  // Assuming isLikedLoading is declared and used to track loading state
      });

      var discussions = await discussionService.getDiscussionsWithPostIds(postdIds);
      if (!this.mounted) return;

      setState(() {
        likedPosts = discussions; // Assuming likedPosts is declared somewhere in your class
        isPostsLoading = false;   // Assuming isPostsLoading is declared and used to track loading state
      });
    } catch (e) {
      // Handle errors if any of the async operations fail
      print('Error initializing data: $e');
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
Widget build(BuildContext context) {
  return (isLikedLoading || isPostsLoading) ? const Center(child: CircularProgressIndicator()) : Scaffold(
    backgroundColor: Colors.black,
    drawer: uid != "" ? common.drawerWidget(context, uid) : Container(),
    body: SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTopNavigation(context),
          Expanded(
            child: likedPosts.isNotEmpty ? ListView.builder(
              controller: _scrollController,
              itemCount: likedPosts.length,
              itemBuilder: (context, index) {
                return buildDiscussionCard(index);
              },
            ) : Center(child: Text("noLiked".tr(), style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
    ),
  );
}

Widget buildTopNavigation(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop()
        ),
      ),
      GestureDetector(
        onTap: () => scrollToTop(),
        child: Text("likedPosts".tr(), style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
    ],
  );
}

void scrollToTop() {
  if (_scrollController.hasClients) {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
    )
  );

  Widget buildDiscussionCard(int index) {
    try {
      if (likedPosts[index]["lottery"] == category || category == "All") {
        var discussion = likedPosts[index];
        return DiscussionCard(
          images: discussion["images"],
          wholeLikes: discussion["likes"].length,
          wholeComments: discussion["comments"].length,
          likes: discussion["likes"],
          bookmarks: discussion["bookmarks"],
          postOwnerUid: discussion["uid"],
          lottery: discussion["lottery"],
          content: discussion["content"],
          postId: discussion["postId"],
          posted: discussion["created"],
        );
      } else {
        return Container();
      }
    } catch (e) {
      print('Error in rendering discussion card at index $index: $e');
      return Container();
    }
  }
}