import 'package:client_app/Services/add-spec-rec.service.dart';
import 'package:client_app/Services/firebase-storage.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../Constants/elementColors.dart';
import '../Constants/fontSizes.dart';
import '../Constants/snackBarMessages.dart';

class AddSpeciesRec extends StatelessWidget {
  const AddSpeciesRec({super.key});

  @override
  Widget build(BuildContext context) {
    return AddSpeciesRecWidget();
  }
}

class AddSpeciesRecWidget extends StatefulWidget {
  const AddSpeciesRecWidget({super.key});

  @override
  State<AddSpeciesRecWidget> createState() => _AddSpeciesRecWidgetState();
}

class _AddSpeciesRecWidgetState extends State<AddSpeciesRecWidget> {
  static final _formKey = GlobalKey<FormState>();

  AddSpeciesRecord _addSpeciesRecord = AddSpeciesRecord();

  bool isImageSelected = false;
  final imageSelController = TextEditingController();
  dynamic pickedImage;

  String sciName = '';
  String commonName = '';
  String imageLink = '';

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

    final sciNameController = TextEditingController();
    final comNameController = TextEditingController();
    final speciesIdController = TextEditingController();

    final ImageStorage _imageStorage = ImageStorage();

    return Scaffold(
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
                    validator: (val) =>
                        val!.isEmpty ? 'Field Cannot be Empty' : null,
                    maxLength: 20,
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
                    decoration: const InputDecoration(
                      labelText: 'Common Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: Text('Conservational Status'),
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
                                      setState(() {
                                        imageDownloadUrl = value;
                                      }),
                                      print('Image Uploaded '),
                                    });
                          },
                          icon: isImageSelected
                              ? const Icon(Icons.file_copy_outlined)
                              : const Icon(Icons.upload),
                        )),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () async {
                      await _addSpeciesRecord.addSpeciesRecord(
                        sciName,
                        commonName,
                        dropdownValue,
                        imageLink,
                      );
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
}
