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
  String conservationStatus;
  String description;
  String scientificName;
  String commonName;
  String altitude;
  String latitude;
  String longitude;

  Species({
    required this.speciesId,
    required this.conservationStatus,
    required this.description,
    required this.scientificName,
    required this.commonName,
    required this.altitude,
    required this.latitude,
    required this.longitude,
  });
}
