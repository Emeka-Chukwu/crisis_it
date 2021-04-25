import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/services/crisis_service.dart';
import 'package:create_it/src/view_model/user.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'details.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.screenWidth(3.5, context)),
            child: Column(
              children: [
                YMargin(Responsive.screenHeight(7, context)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      height: 1.7,
                    ),
                  ),
                ),
                YMargin(Responsive.screenWidth(2, context)),
                Consumer(
                  builder: (context, watch, child) {
                    final crisis = watch(crisisProvider);

                    return crisis.crisisData.length > 0
                        ? Column(
                            children: crisis.crisisData
                                .map(
                                  (e) => Card(
                                      child: Container(
                                    height: 135,
                                    width: Responsive.screenWidth(100, context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: HistoryCard(
                                      model: e,
                                      onTap: () => changeScreen(
                                        context,
                                        DetailsScreen(
                                          model: e,
                                        ),
                                      ),
                                    ),
                                  )),
                                )
                                .toList(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading...",
                              ),
                              YMargin(15),
                              CircularProgressIndicator(
                                backgroundColor: AppColor.green,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.darkGreen),
                              ),
                            ],
                          );
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final CrisisItModel model;
  final Function onTap;

  const HistoryCard({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final videoProvider = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == model.mediaType) {
        init.playRemoteVideos(model.imageUrl, model.id);
      }
      return init;
    });
    return Consumer(
      builder: (context, watch, child) {
        final video = watch(videoProvider);
        return GestureDetector(
          onTap: () => onTap(),
          child: Row(
            children: [
              XMargin(10),
              // Image(
              //   image: AssetImage("fire".png),
              //   width: Responsive.screenWidth(30, context),
              //   height: 100,
              //   fit: BoxFit.cover,
              // ),
              getWidgetHistoryToDisplay(
                  model.mediaType, model.imageUrl, context, video),
              XMargin(15),
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.6,
                          color: Color(0xff0e1a26),
                        ),
                      ),
                      YMargin(Responsive.screenHeight(0.7, context)),
                      Text(
                        model.incidentType,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.6,
                          color: Color(0xff27496D),
                        ),
                      ),
                      YMargin(Responsive.screenHeight(0.7, context)),
                      Text(
                        DateFormat("EEEE d MMMM, yyyy").format(
                            DateTime.fromMicrosecondsSinceEpoch(model.time)),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.6,
                          color: Color(0xff7f8e9d),
                        ),
                      ),
                    ],
                    // #27496D, 100%
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
