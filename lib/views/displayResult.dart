import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/Models/spec-rec.model.dart';
import 'package:client_app/Services/add-spec-rec.service.dart';
import 'package:client_app/Services/species.service.dart';
import 'package:client_app/views/addSpeciesRecord.dart';
import 'package:client_app/views/adminHomeScreen.dart';
import 'package:client_app/views/homeScreen.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/networkError.dart';
import 'package:client_app/views/oopsError.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/elementColors.dart';

class DisplayResultScreen extends StatelessWidget {
  const DisplayResultScreen({super.key, required this.result});

  final Map<String, dynamic> result;

  @override
  Widget build(BuildContext context) {
    return DisplayResultScreenWidget(
      result: result,
    );
  }
}

class DisplayResultScreenWidget extends StatefulWidget {
  const DisplayResultScreenWidget({super.key, required this.result});

  final Map<String, dynamic> result;

  @override
  State<DisplayResultScreenWidget> createState() =>
      _DisplayResultScreenWidgetState();
}

class _DisplayResultScreenWidgetState extends State<DisplayResultScreenWidget> {
  final String scientificName = '';
  String commonName = '';
  final SpeciesRecordService _speciesRecService = SpeciesRecordService();
  final SpeciesService _speciesService = SpeciesService();

  @override
  Widget build(BuildContext context) {
    if (widget.result['class'] == 0) {
      commonName = 'Indian Skipper Frog';
    } else if (widget.result['class'] == 1) {
      commonName = 'Common Shrub Frog';
    } else if (widget.result['class'] == 2) {
      commonName = 'Ceylon Streamlined Frog';
    } else if (widget.result['class'] == 3) {
      commonName = 'Rohan\'s Globular Frog';
    }
    var deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _speciesService.browseSpecies(commonName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: btnColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                '${snapshot.error}',
              ),
            ),
          );
        } else {
          dynamic speciesData = snapshot.data;
          print(widget.result['class']);

          print(speciesData);

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'We Have Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.05),
                      GestureDetector(
                        child: Image.asset(
                          'assets/images/frogs/${commonName}.jpg',
                          scale: 4.5,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.05),
                      Text(
                        speciesData['recs'][0]['common_name'],
                        style: TextStyle(
                          color: mainFontColor,
                          fontSize: textBtnFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.01),
                      Text(
                        speciesData['recs'][0]['scientific_name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: hintFontColor,
                          fontSize: hintTextFontSize,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.05),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var userType = prefs.getString('userType');
                          if (userType == 'admin')
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHomeScreen(),
                              ),
                            );
                          else if (userType == 'user')
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelloHomeScreen(),
                              ),
                            );
                        },
                        child: SizedBox(
                          child: Container(
                            width: deviceSize.width * 0.6,
                            height: deviceSize.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: btnColor,
                            ),
                            child: const Center(
                                child: Text(
                              "Return Home",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: btnTextFontSize),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.05),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Done for now?',
                            style: TextStyle(
                              color: hintFontColor,
                              fontSize: hintTextFontSize,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HelloHomeScreen()));
                            },
                            child: const Text(
                              'Return Home',
                              style: TextStyle(
                                color: mainFontColor,
                                fontSize: textBtnFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
