import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/model/crisis_it.dart';
import 'package:create_it/src/screens/menu/single_view.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class HomeCard extends StatelessWidget {
  final Function add;
  final Function remove;
  final Function like;
  final String imageUrl;
  final String title;
  final String price;
  final int qty;
  final CrisisItModel model;

  const HomeCard({
    Key? key,
    required this.add,
    required this.remove,
    required this.like,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.qty,
    required this.model,
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
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.only(left: 0, right: 0, top: 0),
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            width: Responsive.screenWidth(38, context),
            height: Responsive.screenHeight(30, context),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                // Align(
                //   alignment: Alignment.topRight,
                //   child: GestureDetector(
                //     onTap: () => like(),
                //     child: Icon(
                //       1 == 2 ? Icons.favorite : Icons.favorite_border,
                //     ),
                //   ),
                // ),
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Responsive.screenHeight(18, context),
                  child: getWidgetTODisplay(
                      model.mediaType, model.imageUrl, context, video),
                ),
                YMargin(Responsive.screenHeight(2, context)),
                GestureDetector(
                  onTap: () => changeScreen(
                    context,
                    MenuSingleView(
                      model: model,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        model.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                YMargin(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "by ${model.name}",
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       child: Icon(
                      //         Icons.more_vert,
                      //         color: AppColor.grey,
                      //       ),
                      //       onTap: () => add(),
                      //     ),
                      //     XMargin(10),
                      //   ],
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class WidgetCard extends StatelessWidget {
  final Function add;
  final Function remove;
  final Function like;
  final String imageUrl;
  final String title;
  final String price;
  final int qty;
  final CrisisItModel model;

  const WidgetCard({
    Key? key,
    required this.add,
    required this.remove,
    required this.like,
    this.imageUrl = "assets/images/video.jpg",
    required this.title,
    required this.price,
    required this.qty,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final videoProvider = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == model.mediaType) {
        init.playRemoteVideos(model.imageUrl, "");
      }
      return init;
    });
    return Consumer(
      builder: (context, watch, child) {
        final video = watch(videoProvider);
        return Card(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 10, top: 2),
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: Responsive.screenWidth(50, context),
            height: Responsive.screenHeight(26, context),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CircleAvatar(
                    //   radius: Responsive.screenWidth(10, context),
                    // ),
                    if (MediaType.AUDIO == model.mediaType)
                      Image(
                        image: AssetImage("assets/images/remote_audio.png"),
                        height: Responsive.screenHeight(22, context),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    if (MediaType.VIDEO == model.mediaType)
                      Container(
                        child: VideoPlayer(video.remoteController),
                        height: Responsive.screenHeight(22, context),
                      ),
                    // Image(
                    //   image: AssetImage(imageUrl),
                    //   height: Responsive.screenHeight(2, context),
                    //   fit: BoxFit.cover,
                    //   width: Responsive.screenWidth(100, context),
                    // ),
                    if (MediaType.IMAGE == model.mediaType)
                      Image(
                        image: NetworkImage(imageUrl),
                        height: Responsive.screenHeight(20, context),
                        fit: BoxFit.cover,
                        width: Responsive.screenWidth(100, context),
                      ),
                    YMargin(5),
                    GestureDetector(
                      onTap: () => changeScreen(
                        context,
                        MenuSingleView(
                          model: model,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          model.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.darkBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    YMargin(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "by ${model.name}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.more_vert_outlined,
                            color: AppColor.grey,
                          ),
                          onTap: () => null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WidgetCardVideo extends StatelessWidget {
  final Function add;
  final Function remove;
  final Function like;
  final String imageUrl;
  final String title;
  final String price;
  final int qty;
  final CrisisItModel model;

  const WidgetCardVideo({
    Key? key,
    required this.add,
    required this.remove,
    required this.like,
    this.imageUrl = "assets/images/video.jpg",
    required this.title,
    required this.price,
    required this.qty,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final videoProvider = ChangeNotifierProvider<VideoProvider>((ref) {
      final init = VideoProvider();
      if (MediaType.VIDEO == model.mediaType) {
        init.playRemoteVideos(model.imageUrl, "");
      }
      return init;
    });

    return Consumer(
      builder: (context, watch, child) {
        final video = watch(videoProvider);
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 2),
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: Responsive.screenWidth(50, context),
          height: Responsive.screenHeight(22, context),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   radius: Responsive.screenWidth(10, context),
                  // ),

                  // Image(
                  //   image: AssetImage(imageUrl),
                  //   height: Responsive.screenHeight(22, context),
                  //   fit: BoxFit.cover,
                  //   width: Responsive.screenWidth(100, context),
                  // ),

                  if (MediaType.VIDEO == model.mediaType)
                    VideoPlayer(video.remoteController),

                  YMargin(5),
                  GestureDetector(
                    onTap: () => changeScreen(
                      context,
                      MenuSingleView(
                        model: model,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: AppColor.darkBlue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  YMargin(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: AppColor.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.more_vert_outlined,
                          color: AppColor.grey,
                        ),
                        onTap: () => null,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class WidgetCardImage extends StatelessWidget {
  final Function add;
  final Function remove;
  final Function like;
  final String imageUrl;
  final String title;
  final String price;
  final int qty;
  final CrisisItModel model;

  const WidgetCardImage({
    Key? key,
    required this.add,
    required this.remove,
    required this.like,
    this.imageUrl = "assets/images/video.jpg",
    required this.title,
    required this.price,
    required this.qty,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: Responsive.screenWidth(50, context),
      height: Responsive.screenHeight(22, context),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   radius: Responsive.screenWidth(10, context),
              // ),
              if (MediaType.IMAGE == model.mediaType)
                Image(
                  image: NetworkImage(imageUrl),
                  height: Responsive.screenHeight(22, context),
                  fit: BoxFit.cover,
                  width: Responsive.screenWidth(100, context),
                ),
              YMargin(5),
              GestureDetector(
                onTap: () => changeScreen(
                  context,
                  MenuSingleView(
                    model: model,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              YMargin(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      color: AppColor.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.more_vert_outlined,
                      color: AppColor.grey,
                    ),
                    onTap: () => null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
