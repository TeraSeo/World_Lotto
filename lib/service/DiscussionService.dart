import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery_kr/service/CommentService.dart';
import 'package:lottery_kr/service/StorageService.dart';
import 'package:lottery_kr/service/UserService.dart';
import 'package:uuid/uuid.dart';

class DiscussionService {

  static final DiscussionService _instance = DiscussionService._internal();

  DiscussionService._internal();

  static DiscussionService get instance => _instance;
  
  final CollectionReference discussionCollection = 
        FirebaseFirestore.instance.collection("discussion");
  

  Future<String> addDiscussionData(String uid, String content, String lottery, List<XFile> images) async {
    StorageService storageService = StorageService.instance;
    try {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      String postId = const Uuid().v4();

      List<String> fileNames = [];
      if (images.length > 0) {
        fileNames = await storageService.addImages(images, uid, postId);
      }
      
      List<String> urls = [];
      if (fileNames.length > 0) {
        urls = await storageService.loadPostImages(uid, postId, fileNames);
      }

      await discussionCollection.doc(postId).set({
        "postId": postId,
        "uid": uid,
        "content": content,
        "lottery": lottery,
        "images": urls,
        "comments": [],
        "likes": [],
        "bookmarks": [],
        "created": tsdate,
      });

      return postId;
    } catch(e) {
      print(e);
      return "";
    }
  }

  Future<List<String>> editDicussionData(String postId, String uid, String content, String lottery, List<XFile> images, List<dynamic> originalImages) async {
    StorageService storageService = StorageService.instance;
    try {
      List<String> imagesToDelete = [];

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final discussion = discussionCollection.doc(postId);
      await discussion.get().then(
        (value) {
          Map<String, dynamic> theDiscussion = value.data() as Map<String, dynamic>;
          List<dynamic> originals = theDiscussion["images"];
          if (originalImages.length != originals.length) {
            for (int i = 0; i < originalImages.length; i++) {
              originals.remove(originalImages[i]);
            }
            for (int i = 0; i < originals.length; i++) {
              imagesToDelete.add(originals[i]);
            }
          }
        },
      );
      List<String> fileNames = [];
      if (images.length > 0) {
        fileNames = await storageService.addImages(images, uid, postId);
      }
      
      List<String> urls = [];
      if (fileNames.length > 0) {
        urls = await storageService.loadPostImages(uid, postId, fileNames);
      }

      if (urls.length > 0) {
        for (int i = 0; i < urls.length; i++) {
          originalImages.add(urls[i]);
        }
      }
      await discussion.update({
        "content": content,
        "lottery": lottery,
        "images": originalImages,
        "created": tsdate,
      });

      return imagesToDelete;
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<bool> checkIsPostExists(String postId) async {
    try {
      DocumentReference documentReference = discussionCollection.doc(postId);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      return documentSnapshot.exists;
    } catch (e) {
      print("Error checking post existence: $e");
      return false;
    }
  }

  Future removeDiscussion(String postId, String uId) async {
    UserService userService = UserService.instance;
    StorageService storageService = StorageService.instance;
    CommentService commentService = CommentService.instance;

    try {
      final discussion = discussionCollection.doc(postId);
      await discussion.get().then(
        (value) {
          Map<String, dynamic> theDiscussion = value.data() as Map<String, dynamic>;
          userService.removeUsersLikes(postId, theDiscussion["likes"]);
          userService.removeUsersBookmarks(postId, theDiscussion["bookmarks"]);
          commentService.removeCommentsInPost(theDiscussion["comments"]);
        },
      );
      await discussion.delete();  
      userService.removePost(postId, uId);
      storageService.deleteAllPostImages(uId, postId);
    } catch(e) {
      print(e.toString());
    }
  }

  DocumentSnapshot? lastDocument;
  Future<List<Map<String, dynamic>>> getAllDiscussions(String category) async {
    List<Map<String, dynamic>> discussions = [];
    try {
      if (category == "All") {
        await discussionCollection.limit(10).get().then((value) => {
          value.docs.forEach((element) {
            lastDocument = element;
            Map<String, dynamic> discussion = element.data() as Map<String, dynamic>;
            discussions.add(discussion);
          })
        });
      }
      else {
        await discussionCollection.where("lottery", isEqualTo: category).limit(15).get().then((value) => {
          value.docs.forEach((element) {
            lastDocument = element;
            Map<String, dynamic> discussion = element.data() as Map<String, dynamic>;
            discussions.add(discussion);
          })
        });
      }
      return discussions;
    }
    catch(e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> loadMore(String category) async {
    List<Map<String, dynamic>> discussions = [];

    Query query = discussionCollection.limit(10);
    if (category != "All") {
      query = discussionCollection.where("lottery", isEqualTo: category).limit(15);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    try {
      QuerySnapshot snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }

      for (var doc in snapshot.docs) {
        Map<String, dynamic> discussion = doc.data() as Map<String, dynamic>;
        discussions.add(discussion);
      }
    } catch (e) {
      print("Error fetching more discussions: $e");
    }
    return discussions;
  }

  Future<List<Map<String, dynamic>>> getDiscussionsWithPostIds(List<dynamic> postIds) async {
    List<Map<String, dynamic>> discussions = [];
    print("p: " + postIds.length.toString());
    try {
      for (int i = 0; i < postIds.length; i++) {
        await discussionCollection.doc(postIds[i]).get().then(
          (value) {
            discussions.add(value.data() as Map<String, dynamic>);
          },
        );
      }
    } catch (e) {
      print("Error fetching discussions: $e");
    }
    return discussions;
  }

  Future<List<dynamic>> getComments(String postId) async {
    List<dynamic> comments = [];
    try {
      final discussion = discussionCollection.doc(postId);
      await discussion.get().then((value) {
        comments = value["comments"];
      });
      return comments;
    } catch(e) {
      return [];
    }
  }

  Future addLike(String postId, String uId) async {
    try {
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (!likes.contains(uId)) {
          likes.add(uId);
          discussion.update({
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
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> likes = value["likes"];
        if (likes.contains(uId)) {
          likes.remove(uId);
          discussion.update({
            "likes" : likes,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addComment(String postId, String commentID) async {
    try {
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> comments = value["comments"];
        if (!comments.contains(commentID)) {
          comments.add(commentID);
          discussion.update({
            "comments" : comments,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future removeComment(String postId, String commentID) async {
    try {
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> comments = value["comments"];
        if (comments.contains(commentID)) {
          comments.remove(commentID);
          discussion.update({
            "comments" : comments,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }

  Future addBookmark(String postId, String uId) async {
    try {
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> bookmarks = value["bookmarks"];
        if (!bookmarks.contains(uId)) {
          bookmarks.add(uId);
          discussion.update({
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
      final discussion = discussionCollection.doc(postId);
      discussion.get().then((value) {
        List<dynamic> bookmarks = value["bookmarks"];
        if (bookmarks.contains(uId)) {
          bookmarks.remove(uId);
          discussion.update({
            "bookmarks" : bookmarks,
          });
        }
      });
    } catch(e) {
      print(e.toString());
    }
  }
}