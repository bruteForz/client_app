import 'package:flutter/material.dart';

class SpeciesRecord {
  late String sciName;
  late String commonName;
  late String consStatus;
  late String speciesId;
  late String imageFile;

  SpeciesRecord({
    sciName,
    commonName,
    consStatus,
    speciesId,
    imageFile,
  });
}

class Species {
  String speciesId;
  String image;
  String conservationStatus;
  String description;
  String scientificName;
  String commonName;

  Species({
    required this.speciesId,
    required this.image,
    required this.conservationStatus,
    required this.description,
    required this.scientificName,
    required this.commonName,
  });
}