import 'dart:io';

import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:client_app/views/frogDetailScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FrogDetailScreen extends StatelessWidget {
  FrogDetailScreen(
      {super.key,
      required this.commonName,
      required this.sciName,
      required this.consStatus,
      required this.description});

  String commonName = '';
  String sciName = '';
  String consStatus = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                  Text(
                    commonName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.04),
                  Container(
                      //                 Widget content() {
                      // return Container(
                      child: CarouselSlider(
                          items: [
                        Image.asset('assets/images/IMG1.jpeg'),
                        Image.asset('assets/images/IMG2.jpg'),
                        Image.asset('assets/images/IMG3.jpeg'),
                      ],
                          options: CarouselOptions(
                            height: deviceSize.height * 0.25,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            scrollDirection: Axis.horizontal,
                            enableInfiniteScroll: true,
                          ))),
                  SizedBox(height: deviceSize.height * 0.02),
                  const Text(
                    'Species Name',
                    style: TextStyle(
                      color: mainFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    sciName,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  const Text(
                    'Conservation Status',
                    style: TextStyle(
                      color: mainFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    consStatus,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Text(
                    description,
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
