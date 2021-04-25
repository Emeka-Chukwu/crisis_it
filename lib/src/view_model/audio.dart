import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/model/user.dart';
import 'package:create_it/src/screens/menu/upload_form.dart';
import 'package:create_it/src/services/uploads.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioProvider extends ChangeNotifier {
  UploadHelper uploadHelper = UploadHelper();
  String audioId = "";
  late File file;
  bool started = false;
  bool isPickAudio = false;
  int minutes = 0;
  int seconds = 0;
  int recordDuration = 0;
  bool isRecorder = true;
  bool isPlaying = false;
  Timer? timer;
  bool isRecording = false;
  bool isPaused = false;
  String filePath = "";
  // FlutterSoundPlayer myPlayer = FlutterSoundPlayer();
  AudioPlayer audioPlayer = AudioPlayer();

  void recordAudio() async {
    isRecorder = true;
    isRecording = true;
    int timerNow = DateTime.now().millisecondsSinceEpoch;
    bool result = await Record.hasPermission();
    final directory = await getExternalStorageDirectory();
    Directory extDir = await getApplicationDocumentsDirectory();

    if (directory != null) {
      extDir = directory;
    }
    final String dirPath = '${extDir.path}/media';
    await Directory(dirPath).create(recursive: true);
    filePath = '$dirPath/Rec$timerNow.m4a';
    print(filePath);
    print(extDir);
    print(dirPath);
    notifyListeners();
    if (result) {
      final recorded = await Record.start(
        path: filePath, // required
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
      _startTimer();
    }
  }

  void stopRecordAudio() async {
    isRecording = await Record.isRecording();

    timer?.cancel();
    recordDuration = 0;
    print("kkkkkkkkkkkkkkkkkkkkkk");
    if (isRecording) {
      print(true);
      timer?.cancel();

      await Record.stop();
      isRecording = false;
    }
    isRecorder = false;
    isRecording = false;
    print(isRecording);

    notifyListeners();
  }

  void formaRecordingTime() {
    minutes = recordDuration ~/ 60;
    seconds = (recordDuration % 60).toInt();
    notifyListeners();
  }

  void _startTimer() {
    const tick = const Duration(seconds: 1);
    timer?.cancel();
    timer = Timer.periodic(tick, (Timer t) {
      recordDuration++;
      formaRecordingTime();

      notifyListeners();
    });
  }

  Future<void> pause() async {
    timer?.cancel();
    await Record.pause();

    isPaused = true;
    notifyListeners();
  }

  Future<void> resume() async {
    _startTimer();
    await Record.resume();

    isPaused = false;
    notifyListeners();
  }

  void playTheAudio() async {
    print("playAudio");
    isRecorder = false;
    isPlaying = true;
    notifyListeners();
    if (filePath != "") {
      int result = await audioPlayer.play(filePath, isLocal: true);
      if (result == 1) {
        // success
        _startTimer();
      }
      audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
        // print('Current player state: $s');
        if (s == AudioPlayerState.COMPLETED) {
          timer?.cancel();
          recordDuration = 0;
        }
      });
    }
    notifyListeners();
  }

  void playTheAudioRemote(String url, String id) async {
    int result = await audioPlayer.play(url, volume: 50);
    if (result == 1) {
      // success
      _startTimer();
      audioId = id;
      isRecorder = false;
      started = true;
      isPlaying = true;
      audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
        // print('Current player state: $s');
        if (s == AudioPlayerState.COMPLETED) {
          timer?.cancel();
          recordDuration = 0;
          notifyListeners();
        }
      });
    }

    notifyListeners();
  }

  void stopTheAudioRemote() {
    audioPlayer.stop();
    isPlaying = false;
    started = true;
    timer?.cancel();
    recordDuration = 0;
    notifyListeners();
  }

  void stopTheAudio() {
    print("stopAudio");

    if (filePath != "") {
      audioPlayer.stop();
      isPlaying = false;
      print(isPlaying);
      timer?.cancel();
      recordDuration = 0;
      notifyListeners();
    } else {
      print("filePath");
    }
  }

  void pauseTheAudio() async {
    if (filePath != "") {
      int result = await audioPlayer.pause();
      timer?.cancel();
      isPaused = true;
    }
  }

  void pauseTheAudioRemote() async {
    await audioPlayer.pause();
    timer?.cancel();
    isPaused = true;
  }

  void resumeTheAudioRemote() {
    audioPlayer.resume();
    isPaused = false;
    _startTimer();
  }

  void resumeTheAudio() {
    if (filePath != "") {
      audioPlayer.resume();
      isPaused = false;
      _startTimer();
    }
  }

  void uploadAudioToServer(
    BuildContext context,
    UserModel user,
    String title,
    String details,
    String incidentType,
  ) async {
    if (filePath != "") {
      AlertDialogClass.newDialogLoading(
        context,
        title: "Uploading Audio ...",
        description: "We’re getting your request done. \nKindly wait a bit. ",
      );

      CrisisItModel crisisItModel = CrisisItModel(
        id: "",
        name: user.name,
        imageUrl: "",
        title: title,
        lat: 0,
        long: 0,
        place: "",
        userId: user.id,
        time: DateTime.now().microsecondsSinceEpoch,
        mediaType: MediaType.AUDIO,
        details: details,
        incidentType: incidentType,
      );
      await uploadHelper.submitCrisisData(
          filePath, "audios", crisisItModel, context, user);
      Navigator.pop(context);
      changeScreen(context, MainScreenDashBoard());
    }
  }

  void pickAudio(BuildContext context) async {
    notifyListeners();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    print(result);
    print("result");
    if (result != null) {
      print(result.files.single.path);
      filePath = result.files.single.path!;
      file = File(filePath);
      changeScreenWithoutRoot(
          context,
          UploadFormMenu(
            index: 3,
            filePath: filePath,
          ));
      // CrisisItModel crisisItModel = CrisisItModel(
      //   id: "",
      //   name: user.name,
      //   imageUrl: "",
      //   title: title,
      //   lat: 0,
      //   long: 0,
      //   place: "",
      //   userId: user.id,
      //   mediaType: MediaType.IMAGE,
      // );
      // await uploadHelper.submitCrisisData(filePath, "audios", crisisItModel);
    }
    notifyListeners();
  }
}
