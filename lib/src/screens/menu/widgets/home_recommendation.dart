import 'package:create_it/src/cores/cores.dart';
import 'package:create_it/src/screens/menu/widgets/widgets.dart';
import 'package:create_it/src/view_model/crisis.dart';
import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// CrisisProvider
class HomeRecommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // context.read(crisisProvider).getAllProducts();
    return Consumer(
      builder: (context, watch, child) {
        final crisis = watch(crisisProvider);
        if (crisis.crisisData.isEmpty) {
          crisis.getAllProducts();
        }

        return Container(
          width: double.infinity,
          height: Responsive.screenHeight(28, context),
          child: ListView.builder(
            itemCount: crisis.crisisData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => HomeCard(
              model: crisis.crisisData[index],
              add: () => null,
              like: () => null,
              remove: () => null,
              qty: 2,
              price: "N2000",
              title: "title - name",
              imageUrl: "Imageurl",
            ),
          ),
        );
      },
    );
  }
}

class WidgetCardVideoBuilder extends StatelessWidget {
  final String imagePath;

  const WidgetCardVideoBuilder(
      {Key? key, this.imagePath = "assets/images/video.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(userProvider);
        final crisis = watch(crisisProvider);
        if (crisis.crisisData.isEmpty) {
          // crisis.getAllProducts();
        }

        return Container(
            width: double.infinity,
            height: Responsive.screenHeight(34, context),
            child: crisis.crisisDataVideo.length > 0
                ? ListView.builder(
                    itemCount: crisis.crisisDataVideo.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (crisis.crisisDataVideo.length == 0)
                        return Center(
                          child: Text("No data"),
                        );
                      if (user.userModel.id ==
                          crisis.crisisDataVideo[index].userId)
                        WidgetCard(
                          model: crisis.crisisDataVideo[index],
                          add: () => null,
                          like: () => null,
                          remove: () => null,
                          qty: 2,
                          price: "By Emeka",
                          title: "title - name",
                          imageUrl: crisis.crisisDataVideo[index].imageUrl,
                        );
                      return SizedBox.shrink();
                    },
                  )
                : Center(
                    child: Text(
                      "No Video",
                      style: TextStyle(
                        color: AppColor.darkBlue,
                        fontSize: 16,
                      ),
                    ),
                  ));
      },
    );
  }
}

class WidgetCardBuilder extends StatelessWidget {
  final String imagePath;

  const WidgetCardBuilder(
      {Key? key, this.imagePath = "assets/images/video.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(userProvider);
        final crisis = watch(crisisProvider);
        if (crisis.crisisData.isEmpty) {
          // crisis.getAllProducts();
        }
        return Container(
          width: double.infinity,
          height: Responsive.screenHeight(34, context),
          child: crisis.crisisDataAudio.length > 0
              ? ListView.builder(
                  itemCount: crisis.crisisDataAudio.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    print(
                        "length of audio list ${crisis.crisisDataImage.length}");
                    if (crisis.crisisDataAudio.length == 0)
                      return Center(
                        child: Text("No data"),
                      );
                    if (user.userModel.id ==
                        crisis.crisisDataAudio[index].userId)
                      return WidgetCard(
                        model: crisis.crisisDataAudio[index],
                        add: () => null,
                        like: () => null,
                        remove: () => null,
                        qty: 2,
                        price: "By Emeka",
                        title: "title - name",
                        imageUrl: crisis.crisisDataAudio[index].imageUrl,
                      );
                    return SizedBox.shrink();
                  },
                )
              : Center(
                  child: Text(
                    "No Video",
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class WidgetCardImageBuilder extends StatelessWidget {
  final String imagePath;

  const WidgetCardImageBuilder(
      {Key? key, this.imagePath = "assets/images/video.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final crisis = watch(crisisProvider);
        // if (crisis.crisisData.isEmpty) {
        //   // crisis.getAllProducts();
        // }
        final user = watch(userProvider);

        print(crisis.crisisData);
        print(crisis.crisisDataImage);

        return Container(
          width: double.infinity,
          height: Responsive.screenHeight(35, context),
          child: crisis.crisisDataImage.length > 0
              ? ListView.builder(
                  itemCount: crisis.crisisDataImage.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    print(
                        "length of image list ${crisis.crisisDataImage.length}");
                    // print()
                    print("length of image list ${crisis.crisisData.length}");

                    if (crisis.crisisDataImage.length == 0)
                      return Center(
                        child: Text("No data"),
                      );
                    if (user.userModel.id ==
                        crisis.crisisDataImage[index].userId)
                      return WidgetCard(
                        model: crisis.crisisDataImage[index],
                        add: () => null,
                        like: () => null,
                        remove: () => null,
                        qty: 2,
                        price: "By Emeka",
                        title: "title - name",
                        imageUrl: crisis.crisisDataImage[index].imageUrl,
                      );
                    return SizedBox.fromSize();
                  },
                )
              : Center(
                  child: Text(
                    "No Images",
                    style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class HomeFilesWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final crisis = watch(crisisProvider);
        // if (crisis.crisisData.isEmpty) {
        // crisis.getAllProducts();
        // }

        return Container(
            width: double.infinity,
            // height: Responsive.screenHeight(200, context),
            padding: EdgeInsets.all(5),
            child: Wrap(
              children: crisis.crisisData
                  .map(
                    (e) => HomeCard(
                      model: e,
                      add: () => null,
                      like: () => null,
                      remove: () => null,
                      qty: 2,
                      price: "N2000",
                      title: "title - name",
                      imageUrl: "Imageurl",
                    ),
                  )
                  .toList(),
            ));
      },
    );
  }
}
