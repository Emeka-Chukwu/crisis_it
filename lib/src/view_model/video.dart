import 'dart:async';
import 'dart:io';
import 'dart:math';

// import 'package:camera/camera.dart';
import 'package:create_it/src/cores/change_screen.dart';
import 'package:create_it/src/cores/colors.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/model/user.dart';
import 'package:create_it/src/services/uploads.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:images_picker/images_picker.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_camera/gallery.dart';
// import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  UploadHelper uploadHelper = UploadHelper();
  String videoId = "";
  late File file;
  String videoStringPAth = "";
  late File recordFile;
  bool isPickVideo = false;
  bool isFromGallery = true;
  bool isPlaying = false;
  bool isPaused = false;
  Timer? timer;
  int minutes = 0;
  int seconds = 0;
  int recordDuration = 0;
  // late List<CameraDescription> cameras;

  late VideoPlayerController videoController;
  late VideoPlayerController remoteController;
  late VideoPlayerController recordController;
  // late CameraController controller;
  bool _isRecordingMode = false;
  bool _isRecording = false;
  //  final _timerKey = GlobalKey<VideoTimerState>();
  //
  //
  void compressTheVideoWhenUploading(
      String pathvideo, CrisisItModel crisis, BuildContext context) async {
    // final info = await VideoCompress.getMediaInfo(pathvideo);
    final directory = await getExternalStorageDirectory();
    Directory extDir = await getApplicationDocumentsDirectory();

    if (directory != null) {
      extDir = directory;
    }
    final String dirPath = '${extDir.path}/media';
    await Directory(dirPath).create(recursive: true);
    Random rand = Random();
    // int name = rand.nextInt(1000);
    int endcharactersIndex = pathvideo.lastIndexOf(".");
    String endCharacters = pathvideo.substring(endcharactersIndex);
    final Map<String, dynamic>? response = await LightCompressor.compressVideo(
        path: pathvideo,
        destinationPath: dirPath +
            "vid-${DateTime.now().millisecondsSinceEpoch}$endCharacters",
        videoQuality: VideoQuality.medium,
        isMinBitRateEnabled: false,
        keepOriginalResolution: false);

    if (response!['onSuccess'] != null) {
      final String outputFile = response['onSuccess'];

//       final uint8list = await VideoThumbnail.thumbnailData(
//   video: videofile.path,
//   imageFormat: ImageFormat.JPEG,
//   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//   quality: 25,
// );

      // use the
      uploadHelper.submitCrisisData(outputFile, "video", crisis, context);

      print(outputFile);
      print(
          "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkddddddddddddddddddddddddddddddddddkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdddddddddddddddddddddddd");
      file = File(outputFile);
    } else if (response['onFailure'] != null) {
      // failure message
      print(response['onFailure']);
    } else if (response['onCancelled'] != null) {
      print(response['onCancelled']);
    }

    // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    //   pathvideo,
    //   quality: VideoQuality.LowQuality,
    //   deleteOrigin: false, // It's false by default
    // );
    // String pathCompressed = mediaInfo!.path!;
    // print(mediaInfo.author);
    // print("${mediaInfo.author} ${mediaInfo.path}");
    // file = File(pathCompressed);
    // notifyListeners();
  }

  void pickVideos(UserModel user, [String title = ""]) async {
    isFromGallery = true;
    notifyListeners();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      print(result.files.single.path!);
      print(
          "payyyyyyyyyyyyyyyyyyyyyyyyyyyyyythhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhtttttttttttttttttttttttttttttttt");
      videoStringPAth = result.files.single.path!;

      file = File(result.files.single.path!);
      videoController = VideoPlayerController.file(file)
        ..initialize().then((value) => value);
      videoController.setLooping(false);
      videoController.setVolume(0.0);
      videoController.play();
      isPickVideo = true;
    } else {
      // User canceled the picker
    }
    notifyListeners();
    // compressTheVideoWhenUploading();
  }

  void playRemoteVideos(String videoPath, String id) async {
    // file = File();
    remoteController = VideoPlayerController.network(videoPath)
      ..initialize().then((value) => value);
    remoteController.setLooping(false);
    remoteController.setVolume(10);
    videoId = id;
    // videoController.play();

    notifyListeners();
    // compressTheVideoWhenUploading();
  }

  void playRemote(String videoPath, String id) {
    remoteController = VideoPlayerController.network(videoPath)
      ..initialize().then((value) => value);
    remoteController.setLooping(false);
    remoteController.setVolume(10);

    // videoController.play();

    remoteController.play().then((value) {
      _startTimer();
    });
    videoId = id;
    isPlaying = true;
    isPaused = false;
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
      if (remoteController.value.isPlaying) {
        recordDuration++;
      }
      formaRecordingTime();

      notifyListeners();
    });
  }

  void stopRemote() {
    if (remoteController.value.isPlaying) {
      remoteController.pause();
    }
    timer?.cancel();
    recordDuration = 0;
    videoId = "";
    isPlaying = false;
    isPaused = true;

    // remoteController.seekTo()

    notifyListeners();
  }

  @override
  void dispose() {
    // flickManager.dispose();
    super.dispose();
  }

  uploadVideoToFirebase(context, UserModel user, [String title = ""]) {
    AlertDialogClass.progressBarUpload(context,
        title: "Video uploading",
        description: "Please wait ",
        color: AppColor.darkBlue);
    CrisisItModel crisisItModel = CrisisItModel(
      id: "",
      name: user.name,
      imageUrl: "",
      title: title,
      lat: 0,
      long: 0,
      place: "",
      userId: user.id,
      mediaType: MediaType.VIDEO,
      time: DateTime.now().microsecondsSinceEpoch,
    );

    compressTheVideoWhenUploading(videoStringPAth, crisisItModel, context);
  }

  // void initializeTheCamera() async {
  //   cameras = await availableCameras();
  //   controller = CameraController(cameras[0], ResolutionPreset.max);
  //   controller.initialize().then((value) {
  //     // if (!mounted) {
  //     //   return;
  //     // }
  //   });
  // }

  // void recordVideos() async {
  //   isFromGallery = false;
  //   notifyListeners();

  //   final CameraController? cameraController =
  //       CameraController(cameras[0], ResolutionPreset.max);

  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     // showInSnackBar('Error: select a camera first.');
  //     print("error : Select a camera first");
  //     return;
  //   }

  //   if (cameraController.value.isRecordingVideo) {
  //     return;
  //   }
  //   try {
  //     await cameraController.startVideoRecording();
  //   } on CameraException catch (e) {
  //     // _showCameraException(e);
  //     print(e);
  //     return;
  //   }
  // }

//   Future<String> startVideoRecording() async {
//     print('startVideoRecording');
//     if (!controller.value.isInitialized) {
//       print("l");
//       return '';
//     }
//     _isRecording = true;
//     // _timerKey.currentState.startTimer();

//     final Directory extDir = await getApplicationDocumentsDirectory();
//     final String dirPath = '${extDir.path}/media';
//     await Directory(dirPath).create(recursive: true);
//     final String filePath = '$dirPath/$timerNow.mp4';

//     if (controller.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return '';
//     }

//     try {
// //      videoPath = filePath;
//       await controller.startVideoRecording();
//     } on CameraException catch (e) {
//       print(e);
//       return e.toString();
//     }
//     return filePath;
//   }

  String timerNow() => DateTime.now().millisecondsSinceEpoch.toString();

  //  Future<XFile> stopVideoRecording() async {
  //   if (!controller.value.isRecordingVideo) {
  //     return
  //   }
  //   _timerKey.currentState.stopTimer();
  //   setState(() {
  //     _isRecording = false;
  //   });

  //   try {
  //     await _controller.stopVideoRecording();
  //   } on CameraException catch (e) {
  //     _showCameraException(e);
  //     return null;
  //   }
  // }

  Future recordAVideo(UserModel user, [String title = ""]) async {
    final videoPath = await ImagesPicker.openCamera(
        pickType: PickType.video,
        maxTime: 15,
        quality: 1,
        cropOpt: CropOption(
          aspectRatio: CropAspectRatio.custom,
          cropType: CropType.rect,
        ) // record video max time
        );
    print(videoPath![0].path);

    print(videoPath[0].size);
    print("videoPath");
    String pathV = videoPath[0].path ?? "";
    if (pathV != "") {
      // compressTheVideoWhenUploading();
      videoStringPAth = pathV;
      print(
          "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      // CrisisItModel crisisItModel = CrisisItModel(
      //   id: "",
      //   name: user.name,
      //   imageUrl: "",
      //   title: title,
      //   lat: 0,
      //   long: 0,
      //   place: "",
      //   userId: user.id,
      //   mediaType: MediaType.VIDEO,
      // );
      // compressTheVideoWhenUploading(pathV, crisisItModel);

      file = File(pathV);
    }

    print(pathV);
    print("pathV");

    if (pathV != "") {
      videoController = VideoPlayerController.file(file)
        ..initialize().then((value) => value);
      videoController.setLooping(false);
      videoController.setVolume(20);
      videoController.play();
      isPickVideo = true;
    } else {
      // User canceled the picker
    }
    notifyListeners();
    return videoPath[0].path;
  }
}
