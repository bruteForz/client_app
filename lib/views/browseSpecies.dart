import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/frogDetailScreen.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';
import '../Services/add-spec-rec.service.dart';

class BrowseSpeciesScreen extends StatelessWidget {
  BrowseSpeciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BrowseSpeciesWidget();
  }
}

class BrowseSpeciesWidget extends StatefulWidget {
  const BrowseSpeciesWidget({super.key});

  @override
  State<BrowseSpeciesWidget> createState() => _BrowseSpeciesWidgetState();
}

class _BrowseSpeciesWidgetState extends State<BrowseSpeciesWidget> {
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: deviceSize.height * 0.15),
              Text(
                'Browse Species',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.01),
              BrowseSpeciesWid(),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowseSpeciesWid extends StatefulWidget {
  const BrowseSpeciesWid({super.key});

  @override
  State<BrowseSpeciesWid> createState() => _BrowseSpeciesWidState();
}

class _BrowseSpeciesWidState extends State<BrowseSpeciesWid> {
  final SpeciesRecordService _speciesRecService = SpeciesRecordService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _speciesRecService.getAllSpeciesRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: CircularProgressIndicator(
                color: btnColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final speciesRecords = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: speciesRecords?.length,
            itemBuilder: (context, index) {
              final record = speciesRecords?[index];
              return SizedBox(
                width: double.infinity,
                height: 260,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: btnColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record!['scientific_name'],
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: backgroundColor,
                                  fontSize: btnTextFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                record['common_name'],
                                style: const TextStyle(
                                  color: backgroundColor,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                                const Text(
                                  "Scientific Name",
                                  style: TextStyle(
                                    color: mainFontColor,
                                    fontSize: textBtnFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  record['scientific_name'],
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: hintFontColor,
                                    fontSize: hintTextFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const Text(
                                  "Conservation Status",
                                  style: TextStyle(
                                    color: mainFontColor,
                                    fontSize: textBtnFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  record['conservation_status'],
                                  style: const TextStyle(
                                    color: hintFontColor,
                                    fontSize: hintTextFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FrogDetailScreen(
                                                  commonName:
                                                      record['common_name'],
                                                  sciName:
                                                      record['scientific_name'],
                                                  consStatus: record[
                                                      'conservation_status'],
                                                  description:
                                                      record['description'],
                                                )));
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
                            scale: 3.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
