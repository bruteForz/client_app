import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/frogDetailScreen.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';

class BrowseSpeciesScreen extends StatefulWidget {
  const BrowseSpeciesScreen({super.key});

  @override
  State<BrowseSpeciesScreen> createState() => _BrowseSpeciesScreenState();
}

class _BrowseSpeciesScreenState extends State<BrowseSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    String _searchQuery = '';
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_circle_left,
                size: titleFontSize,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Browse Species',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: btnColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family_name",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: btnTextFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Common_name',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Species Name",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Species_name',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      "Conservation Status",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'EN',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FrogDetailScreen()));
                                      },
                                      child: const Text(
                                        'Read More...',
                                        style: TextStyle(
                                          color: mainFontColor,
                                          fontSize: textBtnFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/browse-icon.png',
                                scale: 2.5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: btnColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family_name",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: btnTextFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Common_name',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Species Name",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Species_name',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      "Conservation Status",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'EN',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FrogDetailScreen()));
                                      },
                                      child: const Text(
                                        'Read More...',
                                        style: TextStyle(
                                          color: mainFontColor,
                                          fontSize: textBtnFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/browse-icon.png',
                                scale: 2.5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: btnColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family_name",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: btnTextFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Common_name',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Species Name",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Species_name',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      "Conservation Status",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'EN',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FrogDetailScreen()));
                                      },
                                      child: const Text(
                                        'Read More...',
                                        style: TextStyle(
                                          color: mainFontColor,
                                          fontSize: textBtnFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/browse-icon.png',
                                scale: 2.5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: btnColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family_name",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: btnTextFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Common_name',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Species Name",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Species_name',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      "Conservation Status",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'EN',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FrogDetailScreen()));
                                      },
                                      child: const Text(
                                        'Read More...',
                                        style: TextStyle(
                                          color: mainFontColor,
                                          fontSize: textBtnFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/browse-icon.png',
                                scale: 2.5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: btnColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family_name",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: btnTextFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Common_name',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Species Name",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Species_name',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      "Conservation Status",
                                      style: TextStyle(
                                        color: mainFontColor,
                                        fontSize: textBtnFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'EN',
                                      style: TextStyle(
                                        color: hintFontColor,
                                        fontSize: hintTextFontSize,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FrogDetailScreen()));
                                      },
                                      child: const Text(
                                        'Read More...',
                                        style: TextStyle(
                                          color: mainFontColor,
                                          fontSize: textBtnFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/browse-icon.png',
                                scale: 2.5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
