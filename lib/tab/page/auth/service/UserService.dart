import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/tab/page/auth/service/DiscussionService.dart';

class UserService {

  static final UserService _instance = UserService._internal();

  UserService._internal();

  static UserService get instance => _instance;
  
  final CollectionReference userCollection = 
        FirebaseFirestore.instance.collection("user");
  
  HelperFunctions helperFunctions = HelperFunctions();

  Future savingeUserData(String name, String email, String uid) async {
    try {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);

      helperFunctions.saveUserLoggedInStatus(true);
      helperFunctions.saveUserUIdSF(uid);
      helperFunctions.saveVerifiedSF(true);

      return await userCollection.doc(uid).set({
        "uid" : uid,
        "name" : name,
        "email" : email,
        "posts" : [],
        "comments" : [],
        "likes" : [],
        "bookmarks" : [],
        "blockedUser" : [],
        "blockedPost" : [],
        "registered" : tsdate,
      });
    } catch(e) {
      print(e);
    }
    
  }

  Future<bool> isUserExists(String uId) async {
    // Get a reference to the Firestore service and the specific document
    final userDoc = FirebaseFirestore.instance.collection("user").doc(uId);
    
    // Attempt to get the document
    final docSnapshot = await userDoc.get();

    // Check if the document exists
    return docSnapshot.exists;
  }

  Future getUserData(String email) async {
    QuerySnapshot querySnapshot = await userCollection.where("email", isEqualTo: email).get();
    return querySnapshot;
  }

  Future getUserName(String uId) async {
    try {
      String userName = "";
      final user = userCollection.doc(uId);
      await user.get().then((value) {
        userName = value["name"];
      });

      return userName;
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeAccount(String uId) async {
    DiscussionService discussionService = DiscussionService.instance;
    try {
      final user = userCollection.doc(uId);
      await user.get().then((value) async {
        List<dynamic> posts = value["posts"];
        for (int i = 0; i < posts.length; i++) {
          print("id: " + posts[i].toString());
          discussionService.removeDiscussion(posts[i], uId);
        }
      });

    } catch(e) {
      print(e.toString());
    }
  }

  Future<bool> checkEmailExist(String email) async {       
    try {
      QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
      if (snapshot.docs.length == 0) {
        return true;
      }
      else {
        return false;
      }
    } catch(e) {
      return false;
    }
  }

  Future addPost(String postId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> posts = value["posts"];
        if (!posts.contains(postId)) {
          posts.add(postId);
          user.update({
            "posts" : posts,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removePost(String postId, String uId) async {
    try {
      final discussion = userCollection.doc(uId);
      discussion.get().then((value) {
        List<dynamic> posts = value["posts"];
        if (posts.contains(postId)) {
          posts.remove(postId);
          discussion.update({
            "posts" : posts,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addComment(String commentId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> comments = value["comments"];
        if (!comments.contains(commentId)) {
          comments.add(commentId);
          user.update({
            "comments" : comments,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeComment(String commentId, String uId) async {
    try {
      final discussion = userCollection.doc(uId);
      discussion.get().then((value) {
        List<dynamic> comments = value["comments"];
        if (comments.contains(commentId)) {
          comments.remove(commentId);
          discussion.update({
            "comments" : comments,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addLike(String postId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (!likes.contains(postId)) {
          likes.add(postId);
          user.update({
            "likes" : likes,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeLike(String postId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (likes.contains(postId)) {
          likes.remove(postId);
          user.update({
            "likes" : likes,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeUsersLikes(String postId, List<dynamic> uIds) async {
    try {
      for (int i = 0; i < uIds.length; i++) {
        removeLike(postId, uIds[i].toString());
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeUsersBookmarks(String postId, List<dynamic> uIds) async {
    try {
      for (int i = 0; i < uIds.length; i++) {
        removeBookmark(postId, uIds[i].toString());
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future addBookmark(String postId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> bookmarks = value["bookmarks"];
        if (!bookmarks.contains(postId)) {
          bookmarks.add(postId);
          user.update({
            "bookmarks" : bookmarks,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeBookmark(String postId, String uId) async {
    try {
      final discussion = userCollection.doc(uId);
      discussion.get().then((value) {
        List<dynamic> bookmarks = value["bookmarks"];
        if (bookmarks.contains(postId)) {
          bookmarks.remove(postId);
          discussion.update({
            "bookmarks" : bookmarks,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addPostReport(String postId, String uId) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> blockedPosts = value["blockedPost"];
        if (!blockedPosts.contains(postId)) {
          blockedPosts.add(postId);
          user.update({
            "blockedPost" : blockedPosts,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addUserReport(String uId, String reportUid) async {
    try {
      final user = userCollection.doc(uId);
      user.get().then((value) {
        List<dynamic> blockedUsers = value["blockedUser"];
        if (!blockedUsers.contains(reportUid)) {
          blockedUsers.add(reportUid);
          user.update({
            "blockedUser" : blockedUsers,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future<List<dynamic>> getReportedPosts(String uId) async {
    try {
       List<dynamic> blockedPosts = [];
      final user = userCollection.doc(uId);
      await user.get().then((value) {
        blockedPosts = value["blockedPost"];
      });
      return blockedPosts;
    } catch(e) {
      return [];
    }
  }

  Future<List<dynamic>> getReportedUsers(String uId) async {
    try {
       List<dynamic> blockedUsers = [];
      final user = userCollection.doc(uId);
      await user.get().then((value) {
        blockedUsers = value["blockedUser"];
      });
      return blockedUsers;
    } catch(e) {
      return [];
    }
  }

  Future getLikedPosts(String uId) async {
    try {
      List<dynamic> likedPosts = [];
      final discussion = userCollection.doc(uId);
      await discussion.get().then((value) {
        likedPosts = value["likes"];
      });
      return likedPosts;
    } catch(e) {
      return [];
    }
  }

  Future getBookmarkedPosts(String uId) async {
    try {
      List<dynamic> bookmarkedPosts = [];
      final discussion = userCollection.doc(uId);
      await discussion.get().then((value) {
        bookmarkedPosts = value["bookmarks"];
      });
      return bookmarkedPosts;
    } catch(e) {
      return [];
    }
  }
}