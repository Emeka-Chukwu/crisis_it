import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/services/crisis_service.dart';
import 'package:flutter/cupertino.dart';

class CrisisProvider extends ChangeNotifier {
  CrisisItData crisisItData = CrisisItData();
  List<CrisisItModel> crisisData = [];
  List<CrisisItModel> crisisDataAudio = [];

  List<CrisisItModel> crisisDataVideo = [];

  List<CrisisItModel> crisisDataImage = [];

  void getAllProducts() async {
    crisisData = await crisisItData.getProducts();
    crisisData.sort((a, b) => DateTime.fromMicrosecondsSinceEpoch(b.time)
        .toString()
        .compareTo(DateTime.fromMicrosecondsSinceEpoch(a.time).toString()));

    notifyListeners();
    separateTheFilesType();
  }

  void separateTheFilesType() {
    crisisDataAudio = [];

    crisisDataVideo = [];

    crisisDataImage = [];
    notifyListeners();
    crisisData.forEach((element) {
      if (element.mediaType == MediaType.AUDIO) {
        print(element.imageUrl);
        crisisDataAudio.add(element);
      } else if (element.mediaType == MediaType.VIDEO) {
        crisisDataVideo.add(element);
      } else if (element.mediaType == MediaType.IMAGE) {
        crisisDataImage.add(element);
      }
    });

    notifyListeners();
  }
}
