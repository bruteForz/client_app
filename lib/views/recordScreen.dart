import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:intl/intl.dart' show DateFormat;

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RecordScreenWidget();
  }
}

class RecordScreenWidget extends StatefulWidget {
  const RecordScreenWidget({super.key});

  @override
  State<RecordScreenWidget> createState() => _RecordScreenWidgetState();
}

class _RecordScreenWidgetState extends State<RecordScreenWidget> {
  late FlutterSoundRecorder _recorder;
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  bool _play = false;
  String _recorderTxt = '';

  void startRec() async {
    _recorder = FlutterSoundRecorder();
    filePath = '/sdcard/Download/temp.wav';
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @override
  void initState() {
    super.initState();
    startRec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 2, 199, 226),
                    Color.fromARGB(255, 6, 75, 210)
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0),
                ),
              ),
              child: Center(
                child: Text(
                  _recorderTxt,
                  style: TextStyle(fontSize: 70),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildElevatedButton(
                  icon: Icons.mic,
                  iconColor: Colors.red,
                  onPressed: record,
                ),
                SizedBox(
                  width: 30,
                ),
                buildElevatedButton(
                  icon: Icons.stop,
                  iconColor: Colors.black,
                  onPressed: stopRecord,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildElevatedButton(
                  icon: Icons.play_arrow,
                  iconColor: Colors.black,
                  onPressed: startPlaying,
                ),
                SizedBox(
                  width: 30,
                ),
                buildElevatedButton(
                  icon: Icons.stop,
                  iconColor: Colors.black,
                  onPressed: stopPlaying,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 10.0,
              ),
              onPressed: () {
                setState(() {
                  _play = !_play;
                });
                if (_play) startPlaying();
                if (!_play) stopPlaying();
              },
              icon: _play
                  ? Icon(
                      Icons.stop,
                    )
                  : Icon(Icons.play_arrow),
              label: _play
                  ? Text(
                      "Stop Playing",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )
                  : Text(
                      "Start Playing",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
      {required IconData icon,
      required Color iconColor,
      required final VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(5.0),
        side: BorderSide(
          color: Colors.orange,
          width: 3.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        primary: Colors.white,
        elevation: 10.0,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: 35.0,
      ),
      label: Text(''),
    );
  }

  Future<void> record() async {
    await _recorder.openRecorder();
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _recorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    return await _recorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }
}

// class RecordScreenWidget extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   State<RecordScreenWidget> createState() => _RecordScreenWidgetState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FlutterSoundRecorder _recorder;
//   final audioPlayer = AssetsAudioPlayer();
//   String filePath;
//   bool _play = false;
//   String _recorderTxt = '00:00:00';

//   @override
//   void initState() {
//     super.initState();
//     startIt();
//   }

//   void startIt() async {
//     filePath = '/sdcard/Download/temp.wav';
//     _recorder = FlutterSoundRecorder();

//     await _recorder.openAudioSession(
//         focus: AudioFocus.requestFocusAndStopOthers,
//         category: SessionCategory.playAndRecord,
//         mode: SessionMode.modeDefault,
//         device: AudioDevice.speaker);
//     await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));
//     await initializeDateFormatting();

//     await Permission.microphone.request();
//     await Permission.storage.request();
//     await Permission.manageExternalStorage.request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(''),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 400.0,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color.fromARGB(255, 2, 199, 226), Color.fromARGB(255, 6, 75, 210)],
//                 ),
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100.0),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   _recorderTxt,
//                   style: TextStyle(fontSize: 70),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildElevatedButton(
//                   icon: Icons.mic,
//                   iconColor: Colors.red,
//                   onPressed: record,
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 buildElevatedButton(
//                   icon: Icons.stop,
//                   iconColor: Colors.black,
//                   onPressed: stopRecord,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildElevatedButton(
//                   icon: Icons.play_arrow,
//                   iconColor: Colors.black,
//                   onPressed: startPlaying,
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 buildElevatedButton(
//                   icon: Icons.stop,
//                   iconColor: Colors.black,
//                   onPressed: stopPlaying,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 elevation: 10.0,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _play = !_play;
//                 });
//                 if (_play) startPlaying();
//                 if (!_play) stopPlaying();
//               },
//               icon: _play
//                   ? Icon(
//                       Icons.stop,
//                     )
//                   : Icon(Icons.play_arrow),
//               label: _play
//                   ? Text(
//                       "Stop Playing",
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     )
//                   : Text(
//                       "Start Playing",
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ElevatedButton buildElevatedButton({IconData icon, Color iconColor, Function f}) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(5.0),
//         side: BorderSide(
//           color: Colors.orange,
//           width: 3.0,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         primary: Colors.white,
//         elevation: 10.0,
//       ),
//       onPressed: f,
//       icon: Icon(
//         icon,
//         color: iconColor,
//         size: 35.0,
//       ),
//       label: Text(''),
//     );
//   }

//   Future<void> record() async {
//     Directory dir = Directory(path.dirname(filePath));
//     if (!dir.existsSync()) {
//       dir.createSync();
//     }
//     _recorder.openAudioSession();
//     await _recorder.startRecorder(
//       toFile: filePath,
//       codec: Codec.pcm16WAV,
//     );

//     StreamSubscription _recorderSubscription = _recorder.onProgress.listen((e) {
//       var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
//       var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

//       setState(() {
//         _recorderTxt = txt.substring(0, 8);
//       });
//     });
//     _recorderSubscription.cancel();
//   }

//   Future<String> stopRecord() async {
//     _recorder.closeAudioSession();
//     return await _recorder.stopRecorder();
//   }

//   Future<void> startPlaying() async {
//     audioPlayer.open(
//       Audio.file(filePath),
//       autoStart: true,
//       showNotification: true,
//     );
//   }

//   Future<void> stopPlaying() async {
//     audioPlayer.stop();
//   }
// }
