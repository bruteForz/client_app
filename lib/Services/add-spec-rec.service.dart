import 'dart:math';

import 'package:client_app/Models/spec-rec.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddSpeciesRecord {

  String getCustomUniqueId() {
    const String pushChars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 12; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }

  Future<void> addSpeciesRecord(String sciName, String comName, String consStat, String image) async {
    final CollectionReference record =
    FirebaseFirestore.instance.collection('species_record');

    String specId = getCustomUniqueId();

    await record.add({
      'scientific_name': sciName,
      'common_name': comName,
      'conservation_status': consStat,
      'species_id': specId,
      'image': image,
    }).then((value) => {
      print(value),
    });
  }
}