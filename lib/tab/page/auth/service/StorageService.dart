import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageService {

  final firebase_storage.FirebaseStorage storage = 
    firebase_storage.FirebaseStorage.instance;

  StorageService._privateConstructor();

  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  Future<List<String>> addImages(List<XFile> images, String uid, String postId) async {
    List<String> imageNames = [];
    try {
      for (int i = 0; i < images.length; i++) {
        File file = File(images[i].path);
        String name = images[i].name;
        print("image name: " + name);
        await storage.ref(uid + '/posts/' + postId + '/' + name).putFile(file);
        imageNames.add(name);
      }
      return imageNames;
    } on firebase_core.FirebaseException catch(e) {
      print(e);
      return [];
    }
  }

  Future<List<String>> loadPostImages(String uid, String postId, List<String> fileName) async {
    List<String> urls = [];
    try {
      for (int i = 0; i < fileName.length; i++) {
        final ref = await storage.ref().child(uid+'/posts/$postId/' + fileName[i].toString());
        final url = await ref.getDownloadURL();
        print("url: " + url);
        urls.add(url);
      }
      return urls;

    } catch (e) {
      return [];
    }
  }

  Future<void> deleteAllPostImages(String uid, String postID) async {
    final storages = storage.ref().child(uid + '/posts/' + postID);
    final results = await storages.listAll();
    for (var result in results.items) {
      await storage.ref().child(result.fullPath).delete();
    }
  }

  Future deleteSpecificPostImages(String uid, String postId, List<String> images) async {
    final storages = storage.ref().child(uid + '/posts/' + postId);
    final results = await storages.listAll();
    for (var result in results.items) {
      for (int i = 0; i < images.length; i++) {
        if (images[i].contains(result.name)) {
          await storage.ref().child(result.fullPath).delete();
        }
      }
    }
  }

  // Future readSpecificPostImages(String uid, String postId) async {
  //   final storages = storage.ref().child(uid + '/posts/' + postId);
  //   final results = await storages.listAll();
  //   for (var result in results.items) {
  //     print("list: " + result.name);
  //   }
  // }
}