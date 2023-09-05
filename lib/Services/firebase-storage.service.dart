import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageStorage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  String imageUrl = '';

  Future<String> uploadFile(String fileName, String filePath) async {
    File file = File(filePath);

    try {
      Reference ref = await storage.ref('images/$fileName');
      UploadTask uploadTask = ref.putFile(file);

      uploadTask.whenComplete(() async {
        try {
          var downloadUrl = await (await uploadTask).ref.getDownloadURL();
          imageUrl = downloadUrl.toString();
          return imageUrl;
        } catch (onError) {
          print("Error");
        }
      });
      return imageUrl;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
