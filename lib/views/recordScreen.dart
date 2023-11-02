import 'dart:async';

import 'dart:io';
import 'package:client_app/views/addSpeciesRecord.dart';
import 'package:client_app/views/filePreviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../Constants/elementColors.dart';
import '../Constants/fontSizes.dart';

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
  bool isRecording = false;
  bool isRecorded = false;
  String _recorderTxt = '00:00';

  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String minutesStr = '00';
  String secondsStr = '00';

// Handle timeStream

  Stream<int> stopWatchStream() {
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController!.close();
      }
    }

    void tick(_) {
      counter++;
      streamController!.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  void startRec() async {
    _recorder = FlutterSoundRecorder();
    filePath = '/sdcard/Download/temp.wav';

    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    timerStream = stopWatchStream();
    timerSubscription = timerStream!.listen((int newTick) {
      setState(() {
        minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
        secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startRec();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Record Call',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: FloatingActionButton(
                onPressed: isRecording ? stopRecord : record,
                child: isRecording ? Icon(Icons.stop) : Icon(Icons.play_arrow),
                backgroundColor: btnColor,
              ),
            ),
            Text(
              '$minutesStr:$secondsStr',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            isRecorded
                ? GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewRecord()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: deviceSize.height * 0.08,
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
                  )
                : SizedBox(height: deviceSize.height * 0.01),
          ],
        ),
      ),
    );
  }

  Future<void> record() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    setState(() {
      isRecording = true;
    });
    await _recorder.openRecorder();
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription recorderSubscription = _recorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
      });
    });
    recorderSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    setState(() {
      isRecording = false;
      isRecorded = true;
    });

    timerSubscription!.cancel();
    timerStream = null;
    setState(() {
      minutesStr = '00';
      secondsStr = '00';
    });

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
