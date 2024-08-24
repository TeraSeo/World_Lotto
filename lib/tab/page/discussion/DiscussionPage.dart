import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/Home.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/tab/page/auth/LoginPage.dart';
import 'package:lottery_kr/tab/page/auth/service/DiscussionService.dart';
import 'package:lottery_kr/tab/page/auth/service/UserService.dart';
import 'package:lottery_kr/tab/page/discussion/AddDiscussionPage.dart';
import 'package:lottery_kr/tab/page/discussion/DiscussionCard.dart';
import 'package:lottery_kr/widget/Widget.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({super.key});

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  bool isLoginned = false;
  bool isDiscussionsLoading = true;

  ScrollController _scrollController = ScrollController();

  HelperFunctions helperFunctions = HelperFunctions();
  DiscussionService discussionService = DiscussionService.instance;
  CommonWidget common = CommonWidget.instance;
  UserService userService = UserService.instance;

  List<Map<String, dynamic>> discussions = [];

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

  String sort = "Latest";
  List<String> sortList = [
    "Latest",
    "Oldest",
    "Popular",
    "Non-Popular"
  ];

  bool isMoreLoading = false;
  bool noMoreToLoad = false;

  String uid = "";
  List<dynamic> blockedPosts = [];
  bool isBlockedPostLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await checkLoginStatus();
      if (isLoginned) {
        if (this.mounted) {
          setState(() {
            uid = FirebaseAuth.instance.currentUser!.uid;
          });
        }
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent - _scrollController.offset <= 100 && !isMoreLoading && !noMoreToLoad) {
            if (this.mounted) {
              setState(() {
                isMoreLoading = true;
              });
            }
            loadMoreDiscussions(category);
          }
        });
        await userService.getReportedPosts(uid).then((value) {
          blockedPosts = value;
          if (this.mounted) {
            setState(() {
              isBlockedPostLoading = false;
            });
          }
        });
        try {
          await getAllDiscussions(category).then((value) {
            if (this.mounted) {
              setState(() {
                discussions = value;
                isDiscussionsLoading = false;
              });
            }
          });
        }
        catch(e) {
          setState(() {
            discussions = [];
            isDiscussionsLoading = false;
          });
        }
      }
    });
  }

  Future<void> checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (this.mounted) {
      if (user != null) {
        setState(() {
          isLoginned = true;
        });
      }

      if (!isLoginned) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      }
    }
  }

  void loadMoreDiscussions(String category) async {
    List<Map<String, dynamic>> newDiscussions = await discussionService.loadMore(category);
    if (newDiscussions.isNotEmpty) {
      setState(() {
        discussions.addAll(newDiscussions);
        isMoreLoading = false;
      });
    } else {
      setState(() { 
        isMoreLoading = false; 
        noMoreToLoad = true;
      });
    }
  }

  Future<List<Map<String, dynamic>>> getAllDiscussions(String category) async {
    return await discussionService.getAllDiscussions(category);
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isDiscussionsLoading || isBlockedPostLoading) ? const Center(child: CircularProgressIndicator()) : Scaffold(
      backgroundColor: Colors.black,
      drawer: uid != "" ? common.drawerWidget(context, uid) : Container(),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              0.0, 
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                        child: Text("Click here to top", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.02, fontStyle: FontStyle.italic)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            border: Border.all(width: MediaQuery.of(context).size.height * 0.002),
                            color: Colors.blueGrey[800],
                          ),
                          child: DropdownButton<String>(
                            value: category,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                            dropdownColor: Colors.grey[800],
                            underline: Container(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            items: categoryList.map(buildMenuItem).toList(),
                            onChanged: (value) {
                              if (this.mounted) {
                                setState(() {
                                  isDiscussionsLoading = true;
                                });
                              }
                              getAllDiscussions(value!).then((val) {
                                if (this.mounted) {
                                  setState(() {
                                    discussions = val;
                                    isDiscussionsLoading = false;
                                    isMoreLoading = false;
                                    noMoreToLoad = false;
                                  });
                                }
                              });
                              if (this.mounted) {
                                setState(() {
                                  category = value;
                                });
                              }
                            },
                          ),
                        ),

                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        //   width: MediaQuery.of(context).size.width * 0.43,
                        //   height: MediaQuery.of(context).size.height * 0.04,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(13)),
                        //     border: Border.all(width: MediaQuery.of(context).size.height * 0.002),
                        //     color: Colors.blueGrey[800],
                        //   ),
                        //   child: DropdownButton<String>(
                        //     value: sort,
                        //     isExpanded: true,
                        //     icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        //     dropdownColor: Colors.grey[800],
                        //     underline: Container(),
                        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        //     items: sortList.map(buildMenuItem).toList(),
                        //     onChanged: (value) {
                        //       if (this.mounted) {
                        //         setState(() {
                        //           sort = value!;
                        //         });
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    ),  
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: discussions.length, // Add one for the loading indicator
                        itemBuilder: (context, index) {
                          if (index < discussions.length) {
                            if (blockedPosts.contains(discussions[index]["postId"])) return Container();
                            else return buildDiscussionCard(index);

                          } else if (isDiscussionsLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Container(); // Empty container to hide spinner when not loading
                          }
                        },
                      ),
                    ),
                  ),
                ]
              )
            ]
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDiscussion()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('contact'.tr()),
          content: Text("worldlotto52@gmail.com"),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.013),
    )
  );

  Future<void> _handleRefresh() async {
    if (mounted) {
        setState(() {
          isMoreLoading = false;
          noMoreToLoad = false;
          isDiscussionsLoading = true;
          isBlockedPostLoading = true;
        });
      }
    try {
      var newDiscussions = await discussionService.getAllDiscussions(category);
      if (mounted) {
        setState(() {
          discussions = newDiscussions;
          isDiscussionsLoading = false;
        });
      }
      await userService.getReportedPosts(uid).then((value) {
        blockedPosts = value;
        if (this.mounted) {
          setState(() {
            isBlockedPostLoading = false;
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          discussions = [];
          isDiscussionsLoading = false;
        });
      }
      print("Error refreshing discussions: $e");
    }
  }

  Widget buildDiscussionCard(int index) {
    try {
      var discussion = discussions[index];
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
    } catch (e) {
      print('Error in rendering discussion card at index $index: $e');
      return Container();
    }
  }
}
