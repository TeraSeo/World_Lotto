import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/service/DiscussionService.dart';
import 'package:lottery_kr/service/UserService.dart';
import 'package:lottery_kr/page/discussion/DiscussionPage.dart';
import 'package:lottery_kr/page/discussion/EditDiscussionPage.dart';
import 'package:lottery_kr/page/discussion/animation/LikeAnimation.dart';
import 'package:lottery_kr/page/discussion/comment/CommentsPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:translator/translator.dart';

class DiscussionCard extends StatefulWidget {
  final List<dynamic> images;
  final int wholeLikes;
  final int wholeComments;
  final List<dynamic> likes;
  final List<dynamic> bookmarks;
  final String postOwnerUid;
  final String lottery;
  final Timestamp posted;
  final String content;
  final String postId;
  const DiscussionCard({super.key, required this.images, required this.wholeLikes, required this.wholeComments, required this.likes, required this.bookmarks, required this.postOwnerUid, required this.lottery, required this.posted, required this.content, required this.postId});

  @override
  State<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends State<DiscussionCard> {
  DiscussionService discussionService = DiscussionService.instance;
  UserService userService = UserService.instance;
  GoogleTranslator googleTranslator = GoogleTranslator();

  final pageController = PageController();
  late List<String> images;

  String? timeDiff = "";
  String uid = "";
  String postOwnerUId = "";
  int wholeLikes = 0;
  int wholeComments = 0;

  bool isAnimating = false;
  bool isLiked = false;
  bool isBookmarked = false;

  String country = "";

  bool isReadMore = false;

  String localeCode = "";
  String translatedText = "";
  bool isTranslated = false;

  bool isReported = false;
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
    }
    images = List<String>.from(widget.images);
    calTimeDiff();
    setCountry();
    wholeLikes = widget.wholeLikes;
    wholeComments = widget.wholeComments;
    isLiked = widget.likes.contains(uid);
    isBookmarked = widget.bookmarks.contains(uid);
    postOwnerUId = widget.postOwnerUid;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Locale currentLocale = context.locale;
    localeCode = currentLocale.languageCode;
  }

  void setCountry() {
    switch(widget.lottery) {
      case "Powerball" || "MegaMillion":
        setState(() {
          country = "🇺🇸";
        }); 
        break;
      case "EuroMillions" || "EuroJackpot":
        setState(() {
          country = "🇪🇺";
        });
        break;
      case "UK Lotto":
        setState(() {
          country = "🇬🇧";
        });
        break;
      case "La Primitiva" || "El Gordo(5/54)":
        setState(() {
          country = "🇪🇸"; 
        });
        break;
      case "SuperEnalotto":
        setState(() {
          country = "🇮🇹";
        });
        break;
      case "Australia Powerball":
        setState(() {
          country = "🇦🇺";
        });
        break;
      case "Lotto 6/45":
        setState(() {
          country = "🇰🇷";
        });
        break;
      case "Lotto 6" || "Lotto 7":
        setState(() {
          country = "🇯🇵";
        });
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  calTimeDiff() {
    DateTime current = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    DateTime posted = DateTime.fromMicrosecondsSinceEpoch(widget.posted.microsecondsSinceEpoch);

    if (current.difference(posted).inSeconds < 60 && current.difference(posted).inSeconds >= 1) {
      timeDiff = current.difference(posted).inSeconds.toString() + "secBefore".tr();
    } 
    else if (current.difference(posted).inMinutes < 60 && current.difference(posted).inMinutes >= 1) {
      timeDiff = current.difference(posted).inMinutes.toString() + "minBefore".tr();
    } 
    else if (current.difference(posted).inHours < 24 && current.difference(posted).inHours >= 1) {
      timeDiff = current.difference(posted).inHours.toString() + "hourBefore".tr();
    }
    else if (current.difference(posted).inDays < 7 && current.difference(posted).inDays >= 1) {
      timeDiff = current.difference(posted).inDays.toString() + "dayBefore".tr();
    }
    else if (current.difference(posted).inDays < 31 && current.difference(posted).inDays >= 7) {
      timeDiff = (current.difference(posted).inDays ~/ 7).toInt().toString() + "weekBefore".tr();
    }
    else if (current.difference(posted).inDays < 365 && current.difference(posted).inDays >= 31) {
      timeDiff = (current.difference(posted).inDays ~/ 31).toInt().toString() + " " + "monthBefore".tr();
    }
    else if (current.difference(posted).inDays >= 365) {
      timeDiff = (current.difference(posted).inDays ~/ 365).toString() + "yearBefore".tr();
    } 
    else {
      timeDiff = "now".tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isReported ? Container() : Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(country + " " + widget.lottery, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.025)),
                IconButton(
                  onPressed: () {
                    _showOptionMenu();
                  }, 
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.white))
              ],
            ),
          ),
          SizedBox(height: 10),
          images.length == 0 ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: 
                      (isTranslated && translatedText != "") ?
                      Text(
                        "tip".tr() + translatedText, 
                        maxLines: 50,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.02)
                      ) :
                      Text(
                        "tip".tr() + widget.content, 
                        maxLines: 50,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.02)
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (localeCode != "" && !isTranslated) {
                      if (translatedText == "") {
                        googleTranslator.translate(widget.content, to: "ko").then((value) {
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
                  child: Text("seeTranslation".tr(), style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height * 0.017)),
                )
              ],
            ),
          ) : Container(),
          images.isNotEmpty ? _buildImageSlider(context) :
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      child: isLiked ? IconButton(
                        onPressed: () async {
                          if (await discussionService.checkIsPostExists(widget.postId)) {
                            discussionService.removeLike(widget.postId, uid);
                            userService.removeLike(widget.postId, uid);
                            if (this.mounted) {
                              setState(() {
                                isLiked = false;
                                isAnimating = false;
                                wholeLikes -= 1;
                              });
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('postDeletedMsg'.tr()),
                            ));
                          }
                        }, 
                        icon: Icon(Icons.favorite, color: Colors.red, size: MediaQuery.of(context).size.height * 0.03)
                      ) : 
                      IconButton(
                        onPressed: () async {
                          if (await discussionService.checkIsPostExists(widget.postId)) {
                            discussionService.addLike(widget.postId, uid);
                            userService.addLike(widget.postId, uid);
                            if (this.mounted) {
                              setState(() {
                                isLiked = true;
                                isAnimating = true;
                                wholeLikes += 1;
                              });
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('postDeletedMsg'.tr()),
                            ));
                          }
                        }, 
                        icon: Icon(Icons.favorite_outline, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03)
                      )
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await discussionService.checkIsPostExists(widget.postId)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommentsPage(postId: widget.postId)),
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('postDeletedMsg'.tr()),
                          ));
                        }
                      }, 
                      icon: Icon(Icons.comment_outlined, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03)
                    ),
                  ],
                ),
                isBookmarked ? IconButton(
                  onPressed: () async {
                    if (await discussionService.checkIsPostExists(widget.postId)) {
                      discussionService.removeBookmark(widget.postId, uid);
                      userService.removeBookmark(widget.postId, uid);
                      if (this.mounted) {
                        setState(() {
                          isBookmarked = false;
                        });
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('postDeletedMsg'.tr()),
                      ));
                    }
                  }, 
                  icon: Icon(Icons.bookmark, color: Colors.blueAccent, size: MediaQuery.of(context).size.height * 0.03)
                ) :
                IconButton(
                  onPressed: () async {
                    if (await discussionService.checkIsPostExists(widget.postId)) {
                      discussionService.addBookmark(widget.postId, uid);
                      userService.addBookmark(widget.postId, uid);
                      if (this.mounted) {
                        setState(() {
                          isBookmarked = true;
                        });
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('postDeletedMsg'.tr()),
                      ));
                    }
                  }, 
                  icon: Icon(Icons.bookmark_outline, color: Colors.white, size: MediaQuery.of(context).size.height * 0.03)
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("likes".tr().replaceAll("({number})", wholeLikes.toString()), style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.017))
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                if (await discussionService.checkIsPostExists(widget.postId)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentsPage(postId: widget.postId)),
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('postDeletedMsg'.tr()),
                  ));
                }
              },
              child: Row(
                children: [
                  Text("viewComments".tr().replaceAll("({number})", wholeComments.toString()), style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height * 0.017))
                ],
              ),
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.012),
          images.length > 0 ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: 
                      (isTranslated && translatedText != "") ?
                      Text(
                        "tip".tr() + translatedText, 
                        maxLines: 50,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.02)
                      ) :
                      Text(
                        "tip".tr() + widget.content, 
                        maxLines: 50,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height * 0.02)
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (localeCode != "" && !isTranslated) {
                      if (translatedText == "") {
                        googleTranslator.translate(widget.content, to: "ko").then((value) {
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
                  child: Text("seeTranslation".tr(), style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height * 0.017)),
                )
              ],
            ),
          ) : Container(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.006),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                timeDiff == "now" ?
                Text(timeDiff!, style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height * 0.016)) :
                Text(timeDiff!, style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height * 0.016))
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: () async {
            if (await discussionService.checkIsPostExists(widget.postId)) {
              if (isLiked) {
                discussionService.removeLike(widget.postId, uid);
                userService.removeLike(widget.postId, uid);
                if (this.mounted) {
                  setState(() {
                    isLiked = false;
                    isAnimating = false;
                    wholeLikes -= 1;
                  });
                }
              }
              else {
                discussionService.addLike(widget.postId, uid);
                userService.addLike(widget.postId, uid);
                if (this.mounted) {
                  setState(() {
                    isLiked = true;
                    isAnimating = true;
                    wholeLikes += 1;
                  });
                }
              }
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('postDeletedMsg'.tr()),
              ));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 1.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: pageController,
                  itemBuilder: (_, index) => Image.network(images[index], fit: BoxFit.cover),
                  itemCount: images.length,
                ),
                AnimatedOpacity(
                  opacity: isAnimating ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: LikeAnimation(
                    isAnimating: isAnimating,
                    duration: Duration(milliseconds: 400),
                    child: Icon(Icons.favorite, color: Colors.white, size: MediaQuery.of(context).size.height * 0.06),
                    onEnd: () {
                      if (this.mounted) {
                        setState(() {
                          isAnimating = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        images.length > 1 ? Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
          child: SmoothPageIndicator(
            controller: pageController,
            count: images.length,
            effect: SwapEffect(
              activeDotColor: Colors.white,
              dotHeight: MediaQuery.of(context).size.height * 0.01,
              dotWidth: MediaQuery.of(context).size.height * 0.01,
              spacing: MediaQuery.of(context).size.height * 0.005,
            ),
          ),
        ) : Container()
      ],
    );
  }

  void _showOptionMenu() {
    if (uid == postOwnerUId) {
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
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("editPost".tr()),
                  onTap: () {
                    if (!isDeleted) {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditDiscussionPage(postId: widget.postId, category: widget.lottery, content: widget.content, images: widget.images))
                      );
                    }
                    else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DiscussionPage())
                        );
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove_circle),
                  title: Text("removePost".tr()),
                  onTap: () async {
                    if (!isDeleted) {
                      if (this.mounted) {
                        setState(() {
                          isDeleted = true;
                        });
                      }
                      await discussionService.removeDiscussion(widget.postId, widget.postOwnerUid).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DiscussionPage())
                        );
                      });
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('postDeletedMsg'.tr()),
                      ));
                      Navigator.of(context).pop();
                    } 
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
              ],
            ),
          );
        }
      );
    }
    else {
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
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("likePost".tr()),  // 'Like this post'
                  onTap: () async {
                    if (await discussionService.checkIsPostExists(widget.postId)) {
                      if (isLiked) {
                        discussionService.removeLike(widget.postId, uid);
                        userService.removeLike(widget.postId, uid);
                        if (this.mounted) {
                          setState(() {
                            isLiked = false;
                            isAnimating = false;
                            wholeLikes -= 1;
                          });
                        }
                      }
                      else {
                        discussionService.addLike(widget.postId, uid);
                        userService.addLike(widget.postId, uid);
                        if (this.mounted) {
                          setState(() {
                            isLiked = true;
                            isAnimating = true;
                            wholeLikes += 1;
                          });
                        }
                      }
                      Navigator.of(context).pop();
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('postDeletedMsg'.tr()),
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text("bookmark".tr()),
                  onTap: () async {
                    if (await discussionService.checkIsPostExists(widget.postId)) {
                      if (isBookmarked) {
                        discussionService.removeBookmark(widget.postId, uid);
                        userService.removeBookmark(widget.postId, uid);
                        if (this.mounted) {
                          setState(() {
                            isBookmarked = false;
                          });
                        }
                      }
                      else {
                        discussionService.addBookmark(widget.postId, uid);
                        userService.addBookmark(widget.postId, uid);
                        if (this.mounted) {
                          setState(() {
                            isBookmarked = true;
                          });
                        }
                      }
                      Navigator.of(context).pop();
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('postDeletedMsg'.tr()),
                      ));
                      Navigator.of(context).pop();
                    }
                  }
                ),
                ListTile(
                  leading: Icon(Icons.report, color: Colors.red,),
                  title: Text("report".tr()),
                  onTap: () {
                    showReportDialog();
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02)
              ],
            ),
          );
        }
      );
    }
  }

  void showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("confrimReport".tr()),
          content: Text("askReportPost".tr()),
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
                  if (this.mounted) {
                    setState(() {
                      isReported = true;
                    });
                  }
                  userService.addPostReport(widget.postId, uid).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully reported!'),
                      )
                    );
                  });
                }
                else {
                  Navigator.of(context).pop();
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
}
