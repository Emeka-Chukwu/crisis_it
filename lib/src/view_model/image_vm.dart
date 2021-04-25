import 'dart:io';

import 'package:create_it/src/cores/change_screen.dart';
import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/dashboard/main_screens.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/model/user.dart';
import 'package:create_it/src/screens/menu/upload_form.dart';
import 'package:create_it/src/services/uploads.dart';
import 'package:create_it/src/widgets/progress_bar.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:images_picker/images_picker.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_camera/gallery.dart';
// import 'package:flutter/services.dart';

class ImagesProvider extends ChangeNotifier {
  UploadHelper uploadHelper = UploadHelper();
  late File file;
  String filePath = "";
  bool isPickVideo = false;
  bool isFromGallery = true;

  //  final _timerKey = GlobalKey<VideoTimerState>();
  //

  Future<File> compressAndGetFile(String imagePath, CrisisItModel crisis,
      BuildContext context, UserModel user) async {
    final directory = await getExternalStorageDirectory();
    Directory extDir = await getApplicationDocumentsDirectory();

    if (directory != null) {
      extDir = directory;
    }
    final String dirPath = '${extDir.path}/media/images';
    await Directory(dirPath).create(recursive: true);
    int endcharactersIndex = imagePath.lastIndexOf(".");
    String endCharacters = imagePath.substring(endcharactersIndex);
    var result = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      "$dirPath+img-${DateTime.now().millisecondsSinceEpoch}.$endCharacters",
      quality: 88,
      // rotate: 180,
    );
    if (result != null) {
      await uploadHelper.submitCrisisData(
          result.path, "images", crisis, context, user, 1);
    }
    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  void pickImages(UserModel user, BuildContext context,
      [String title = ""]) async {
    isFromGallery = true;
    notifyListeners();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    print(result);
    print("result");
    if (result != null) {
      print(result.files.single.path);
      filePath = result.files.single.path!;
      file = File(filePath);
      changeScreenWithoutRoot(
          context,
          UploadFormMenu(
            index: 1,
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
      // compressAndGetFile(filePath, crisisItModel);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // flickManager.dispose();
    super.dispose();
  }

  void recordAnImage(UserModel user, BuildContext context,
      [String title = ""]) async {
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
    final imagePath = await ImagesPicker.openCamera(
        pickType: PickType.image,
        maxTime: 15,
        quality: 1,
        cropOpt: CropOption(
          aspectRatio: CropAspectRatio.custom,
          cropType: CropType.rect,
        ) // record video max time
        );
    print(imagePath![0].path);
    filePath = imagePath[0].path!;

    print(imagePath[0].size);
    print("imagePath");
    String pathV = imagePath[0].path ?? "";
    if (pathV != "") {
      file = File(pathV);
      changeScreenWithoutRoot(
          context,
          UploadFormMenu(
            index: 1,
            filePath: filePath,
          ));
      // compressAndGetFile(pathV, crisisItModel);
      filePath = pathV;
    }
    notifyListeners();
  }

  void sendFileToFirebase(BuildContext context, UserModel user, String title,
      String details, String incidentType) {
    AlertDialogClass.newDialogLoading(
      context,
      title: "Uploading Image ...",
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
      mediaType: MediaType.IMAGE,
      time: DateTime.now().microsecondsSinceEpoch,
      details: details,
      incidentType: incidentType,
    );

    compressAndGetFile(file.path, crisisItModel, context, user);
    // Navigator.pop(context);
    // changeScreen(context, MainScreenDashBoard());
  }
}
