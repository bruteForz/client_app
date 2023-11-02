import 'package:client_app/Constants/elementColors.dart';
import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/addSpeciesRecord.dart';
import 'package:client_app/views/browseSpecies.dart';
import 'package:client_app/views/homeScreen.dart';
import 'package:client_app/views/readyToRecordScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminHomeScreenWidget();
  }
}

class AdminHomeScreenWidget extends StatefulWidget {
  const AdminHomeScreenWidget({super.key});

  @override
  State<AdminHomeScreenWidget> createState() => _AdminHomeScreenWidgetState();
}

class _AdminHomeScreenWidgetState extends State<AdminHomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    Future<String?> getUserId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userId');
    }

    Future<String?> getUserName() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userName');
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              // _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              size: titleFontSize,
              semanticLabel: 'Logout',
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
                  FutureBuilder<String?>(
                    future: getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return Text(
                          'Hello! ${snapshot.data}',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Text('User data not found.');
                      }
                    },
                  ),
                  SizedBox(height: deviceSize.height * 0.08),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReadyToRecordScreen()));
                    },
                    child: Image.asset(
                      'assets/images/rec-icon.png',
                      scale: 4.1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReadyToRecordScreen()));
                    },
                    child: const Text(
                      'Record a Call',
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: textBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Find a location with no background noise, such as loud animals, horns or traffic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrowseSpeciesScreen()));
                    },
                    child: Image.asset(
                      'assets/images/browse-icon.png',
                      scale: 2.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrowseSpeciesScreen()));
                    },
                    child: const Text(
                      'Browse Species',
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: textBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Discover frog species in Sri Lanka based on your preference',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSpeciesRec()));
                    },
                    child: Image.asset(
                      'assets/images/browse-icon.png',
                      scale: 2.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSpeciesRec()));
                    },
                    child: const Text(
                      'Add Species Record',
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: textBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Add a new Species Record',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
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
