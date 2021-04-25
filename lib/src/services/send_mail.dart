import 'dart:convert';

import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/model/user.dart';
import 'package:http/http.dart' as http;

class SendEmailToAdmin {
  Future<Map> sendTheEmail(
      CrisisItModel crisisItModel, UserModel userModel) async {
    var url = Uri.parse("https://crisisit.herokuapp.com/api/mail/sendmail");

    http.Client client = http.Client();

    final data = await client.post(url,
        body: jsonEncode(
          {
            "name": userModel.name,
            "email": userModel.email,
            "crisis": crisisItModel,
          },
        ),
        headers: {
          "content-type": "application/json",
        });
    final body = data.body;
    return jsonDecode(body);
  }
}
