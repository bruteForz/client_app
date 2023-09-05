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

class FrogDetailScreen extends StatefulWidget {
  const FrogDetailScreen({super.key});

  @override
  State<FrogDetailScreen> createState() => _FrogDetailScreenState();
}

class _FrogDetailScreenState extends State<FrogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FrogDetailScreenWidget();
  }
}

class FrogDetailScreenWidget extends StatefulWidget {
  const FrogDetailScreenWidget({super.key});

  @override
  State<FrogDetailScreenWidget> createState() => _FrogDetailScreenWidgetState();
}

class _FrogDetailScreenWidgetState extends State<FrogDetailScreenWidget> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
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
                    'common_name',
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
                  const Text(
                    'Species_name',
                    style: TextStyle(
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
                  const Text(
                    'EN',
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  const Text(
                    'Small Description abot frog species. Frogs in Sri Lanka are a diverse and fascinating group of amphibians that play a crucial role in the countrys ecosystem. Sri Lanka boasts a remarkable variety of frog species, with over 120 documented so far, many of which are endemic to the island. These frogs exhibit an array of colors, sizes, and adaptations, making them a subject of interest for both scientists and nature enthusiasts. ',
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
