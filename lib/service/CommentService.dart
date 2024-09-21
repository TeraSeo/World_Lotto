import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_kr/service/DiscussionService.dart';
import 'package:lottery_kr/service/UserService.dart';
import 'package:uuid/uuid.dart';

class CommentService {

  static final CommentService _instance = CommentService._internal();

  CommentService._internal();

  static CommentService get instance => _instance;
  
  final CollectionReference commentCollection = 
        FirebaseFirestore.instance.collection("comment");

  Future addComment(String content, String uid, String postId) async {
    UserService userService = UserService.instance;
    DiscussionService discussionService = DiscussionService.instance;

    try {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      String commentId = const Uuid().v4();

      userService.addComment(commentId, uid);
      discussionService.addComment(postId, commentId);

      return await commentCollection.doc(commentId).set({
        "commentId" : commentId,
        "content" : content,
        "uid" : uid,
        "replied" : [],
        "likes" : [],
        "registered" : tsdate,
      });
    } catch(e) {
      print(e);
    }
  }

  Future<void> removeAllCommentsByPostId(String postId) async {
    try {
      var querySnapshot = await commentCollection.where("postId", isEqualTo: postId).get();

      WriteBatch batch = FirebaseFirestore.instance.batch();
      
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference); 
      }

      await batch.commit();
    } catch (e) {
      print("Error removing comments: $e");
    }
  }

  Future<bool> checkIsCommentExists(String commentId) async {
    try {
      DocumentReference documentReference = commentCollection.doc(commentId);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      return documentSnapshot.exists;
    } catch (e) {
      print("Error checking post existence: $e");
      return false;
    }
  }

  Future editComment(String commentId, String content) async {
    try {
      final comment = commentCollection.doc(commentId);
      comment.update({
        "content" : content,
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeComment(String commentId, String postId, String uId) async {
    DiscussionService discussionService = DiscussionService.instance;
    UserService userService = UserService.instance;
    try {
      final comment = commentCollection.doc(commentId);
      await comment.delete();
      await discussionService.removeComment(postId, commentId);
      userService.removeComment(commentId, uId);
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeCommentsInPost(List<dynamic> commentIds) async {
    try {
      for (int i = 0; i < commentIds.length; i++) {
        final comment = commentCollection.doc(commentIds[i]);
        await comment.delete();
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAllComments(List<dynamic> commentIds) async {
    List<Map<String, dynamic>> comments = [];
    try {
      for (int i = 0; i < commentIds.length; i++) {
        final comment = commentCollection.doc(commentIds[i]);
        await comment.get().then((value) {
          comments.add(value.data() as Map<String, dynamic>);
        });
      }
      return comments;
    }
    catch(e) {
      return [];
    }
  }

  Future addLike(String commentId, String uId) async {
    try {
      final comment = commentCollection.doc(commentId);
      comment.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (!likes.contains(uId)) {
          likes.add(uId);
          comment.update({
            "likes" : likes,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeLike(String commentId, String uId) async {
    try {
      final comment = commentCollection.doc(commentId);
      comment.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (likes.contains(uId)) {
          likes.remove(uId);
          comment.update({
            "likes" : likes,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

}