import 'package:client_app/Models/spec-rec.model.dart';
import 'package:client_app/Services/add-spec-rec.service.dart';
import 'package:client_app/Services/firebase-storage.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Constants/elementColors.dart';
import '../Constants/fontSizes.dart';
import '../Constants/snackBarMessages.dart';

class AddSpeciesRec extends StatelessWidget {
  const AddSpeciesRec({super.key, required this.species});

  final Species species;

  @override
  Widget build(BuildContext context) {
    return AddSpeciesRecWidget(
      species: species,
    );
  }
}

class AddSpeciesRecWidget extends StatefulWidget {
  const AddSpeciesRecWidget({super.key, required this.species});

  final Species species;

  @override
  State<AddSpeciesRecWidget> createState() => _AddSpeciesRecWidgetState();
}

class _AddSpeciesRecWidgetState extends State<AddSpeciesRecWidget> {
  final _formKey = GlobalKey<FormState>();

  final SpeciesRecordService _speciesRecordService = SpeciesRecordService();

  bool isImageSelected = false;
  final imageSelController = TextEditingController();
  dynamic pickedImage;

  String sciName = '';
  String commonName = '';
  String imageLink = '';
  String description = '';
  String buttonText = 'Add Location';

  late String imageDownloadUrl;

  String dropdownValue = 'EX';
  // List of items in our dropdown menu
  final consStatus = [
    'EX',
    'CR',
    'EN',
    'VU',
    'NT',
    'LC',
    'DD',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final ImageStorage _imageStorage = ImageStorage();

    sciName = widget.species.scientificName;
    commonName = widget.species.commonName;
    imageLink = widget.species.image;
    description = widget.species.description;
    dropdownValue = widget.species.conservationStatus;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            size: titleFontSize,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Species Record',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.07),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        sciName = val;
                      });
                    },
                    initialValue: sciName,
                    validator: (val) =>
                        val!.isEmpty ? 'Field Cannot be Empty' : null,
                    decoration: const InputDecoration(
                      labelText: 'Scientific Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      commonName = val;
                    }),
                    initialValue: commonName,
                    decoration: const InputDecoration(
                      labelText: 'Common Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      description = val;
                    }),
                    initialValue: description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: const Text('Conservational Status'),
                    items: consStatus.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    isExpanded: true,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
                  ),
                  TextFormField(
                    controller: imageSelController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Upload Image',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg'],
                            );
                            if (results == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(fileSelectionFailed);
                              return null;
                            }
                            final path = results.files.single.path!;
                            final fileName = results.files.single.name;
                            setState(() {
                              imageSelController.text = path;
                              isImageSelected = true;
                              pickedImage = results;
                              imageLink = 'images/$fileName';
                            });
                            _imageStorage
                                .uploadFile(fileName, path)
                                .then((value) => {
                                      print(value),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(imageUploadSuccess),
                                    });
                          },
                          icon: isImageSelected
                              ? const Icon(Icons.file_copy_outlined)
                              : const Icon(Icons.upload),
                        )),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var status = await Permission.location.status;
                      if (!status.isGranted) {
                        await Permission.location.request();
                      }
                      if (status.isGranted) {
                        Position position = await getLocation();
                        if (position != null) {
                          double latitude = position.latitude;
                          double longitude = position.longitude;
                          position;
                          setState(() {
                            buttonText =
                                'Latitude: $latitude, Longitude: $longitude';
                          });
                          print("Latitude: $latitude, Longitude: $longitude");
                        } else {
                          print('location update error');
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: deviceSize.height * 0.05,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: btnColor,
                      ),
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () async {
                      dynamic addSpecies =
                          await _speciesRecordService.addSpeciesRecord(
                        sciName,
                        commonName,
                        dropdownValue,
                        imageLink,
                        description,
                      );
                      if (addSpecies) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(speciesRecordAddFailed);
                      }
                      ScaffoldMessenger.of(context)
                          .showSnackBar(speciesRecordAddSuccess);
                    },
                    child: Container(
                      width: double.infinity,
                      height: deviceSize.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: btnColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Create Species Record',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: btnTextFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
}
