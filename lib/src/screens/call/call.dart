import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DialCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(5, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(Responsive.screenHeight(8, context)),
              Text(
                "Contact",
                style: TextStyle(
                  color: Color(0xff27496d),
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  height: 1.6,
                ),
              ),
              Text(
                "Dial an emergency number here",
                style: TextStyle(
                  color: AppColor.lightGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              YMargin(Responsive.screenHeight(5, context)),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Emergency 112"),
                      ),
                      GestureDetector(
                        onTap: () => _makePhoneCall('tel:112'),
                        child: Icon(
                          Icons.call,
                          color: AppColor.green,
                        ),
                      ),
                      XMargin(20),
                      GestureDetector(
                        child: Icon(
                          Icons.more_vert,
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Emergency 119"),
                      ),
                      GestureDetector(
                        onTap: () => _makePhoneCall('tel:119'),
                        child: Icon(
                          Icons.call,
                          color: AppColor.green,
                        ),
                      ),
                      XMargin(20),
                      GestureDetector(
                        child: Icon(
                          Icons.more_vert,
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              )
            ],
          )),
    );
    ;
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
