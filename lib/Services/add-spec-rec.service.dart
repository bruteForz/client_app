import 'dart:math';

import 'package:client_app/Models/spec-rec.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpeciesRecordService {
  String getCustomUniqueId() {
    const String pushChars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
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

  Future<bool?> addSpeciesRecord(String sciName, String comName,
      String consStat, String image, String description) async {
    final CollectionReference record =
        FirebaseFirestore.instance.collection('species_record');

    String specId = getCustomUniqueId();

    try {
      await record.add({
        'scientific_name': sciName,
        'common_name': comName,
        'conservation_status': consStat,
        'species_id': specId,
        'image': image,
        'description': description,
      });

      return false;
    } catch (e) {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getAllSpeciesRecords() async {
    List<Map<String, dynamic>> speciesRecords = [];

    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('species_record').get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        speciesRecords.add(docSnapshot.data() as Map<String, dynamic>);
      }

      return speciesRecords;
    } catch (e) {
      print('Error fetching species records: $e');
      return speciesRecords;
    }
  }

  // Future<Species?> getSingleSpeciesRecordByAttribute(
  //     dynamic speciesName) async {
  //   Species speciesRecord = Species(
  //     speciesId: '',
  //     image: '',
  //     conservationStatus: '',
  //     description: '',
  //     scientificName: '',
  //     commonName: '',
  //   );
  //   var data;

  //   try {
  //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('species_record')
  //         .where('common_name', isEqualTo: speciesName)
  //         .limit(1)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       final docSnapshot = querySnapshot.docs.first;
  //       data = docSnapshot.data();
  //       speciesRecord.speciesId = data['species_id'];
  //       speciesRecord.image = data['image'];
  //       speciesRecord.conservationStatus = data['conservation_status'];
  //       speciesRecord.description = data['description'];
  //       speciesRecord.scientificName = data['scientific_name'];
  //       speciesRecord.commonName = data['common_name'];
  //     }
  //     return speciesRecord;
  //   } catch (e) {
  //     print('Error fetching species record: $e');
  //     return null;
  //   }
  // }
}
