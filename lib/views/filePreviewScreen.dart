import 'package:client_app/Constants/elementColors.dart';
import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/displayResult.dart';
import 'package:client_app/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PreviewRecord extends StatelessWidget {
  const PreviewRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewRecordWidget();
  }
}

class PreviewRecordWidget extends StatefulWidget {
  const PreviewRecordWidget({super.key});

  @override
  State<PreviewRecordWidget> createState() => _PreviewRecordWidgetState();
}

class _PreviewRecordWidgetState extends State<PreviewRecordWidget> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Denoised Audio',
            style:
                TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: deviceSize.height * 0.08),
          Center(
            child: Image.asset(
              'assets/images/sound.png',
              scale: 3.0,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          Text(
            'temp.wav',
            style: TextStyle(
              fontSize: btnTextFontSize,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.05),
          Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                dynamic fileUpload = await uploadAudioFile();
                print(fileUpload);
                if (fileUpload.length > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayResultScreen(result: fileUpload),
                    ),
                  );
                }
              },
              child: Container(
                width: deviceSize.width * 0.5,
                height: deviceSize.height * 0.08,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: btnColor,
                ),
                child: const Center(
                  child: Text(
                    'Analyze Record',
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: btnTextFontSize,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future uploadAudioFile() async {
    print('method called');
    final url = Uri.parse(
        'http://192.168.43.145:5000/classify-audio'); // Replace with your API endpoint

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'audio',
      '/sdcard/Download/temp.wav',
    ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        return (jsonResponse);
        // Handle the JSON response here
      } else {
        return ('Error: ${response.statusCode}');
      }
    } catch (e) {
      return ('Error: $e');
    }
  }
}
