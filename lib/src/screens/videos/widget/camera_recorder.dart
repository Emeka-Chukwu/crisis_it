// import 'package:camera/camera.dart';
// import 'package:create_it/src/view_model/video.dart';
// import 'package:flutter/material.dart';

// class CameraRecorder extends StatelessWidget {
//   final VideoProvider videoProvider;

//   const CameraRecorder({Key? key, required this.videoProvider})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unnecessary_null_comparison
//     final size = MediaQuery.of(context).size;
//     if (videoProvider.controller != null) {
//       if (!videoProvider.controller.value.isInitialized) {
//         return Container();
//       } else {
//         return const Center(
//           child: SizedBox(
//             width: 32,
//             height: 32,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       }
//     }
//     if (!videoProvider.controller.value.isInitialized) {
//       return Container();
//     }

//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 24.0,
//               left: 12.0,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.switch_camera,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   // _onCameraSwitch();
//                 },
//               ),
//             ),
//             //bbbbbbbbbbb
//             ClipRect(
//               child: Container(
//                 child: Transform.scale(
//                   scale: videoProvider.controller.value.aspectRatio /
//                       size.aspectRatio,
//                   child: Center(
//                     child: AspectRatio(
//                       aspectRatio: videoProvider.controller.value.aspectRatio,
//                       child: CameraPreview(videoProvider.controller),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
