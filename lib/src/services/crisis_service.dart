import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_it/src/model/crisis_it.dart';

class CrisisItData {
  Future<List<CrisisItModel>> getProducts() async {
    List<CrisisItModel> crisis = [];

    final crisisM = await FirebaseFirestore.instance
        .collection("crisis")
        .get()
        .then((value) => value);
    for (var prod in crisisM.docs) {
      crisis.add(CrisisItModel.fromJson(prod));
    }
    print("print all the data from the data");
    print(crisis);
    return crisis;
  }
}
