// import 'package:flutter/material.dart';
// import 'package:learning_input_image/learning_input_image.dart';
// import 'package:learning_text_recognition/learning_text_recognition.dart';

// class TextRecolonizationScreen extends StatefulWidget {
//   const TextRecolonizationScreen({super.key});

//   @override
//   State<TextRecolonizationScreen> createState() =>
//       _TextRecolonizationScreenState();
// }

// class _TextRecolonizationScreenState extends State<TextRecolonizationScreen> {
//   TextRecognition textRecognition = TextRecognition();
//   String? name;
//   RecognizedText? result;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 600,
//               width: 300,
//               child: InputCameraView(
//                 canSwitchMode: false,
//                 mode: InputCameraMode.gallery,
//                 title: 'Upload your Id',
//                 onImage: (InputImage image) async {
//                   print("================>");
//                   print(image.json);
//                   print("=============Row Data========>");
//                   print(image.metadata?.json);

//                   result = await textRecognition.process(image);

//                   print(
//                       "**************************Recognize Text***************");
//                   print(result?.text);
//                   name = result?.blocks
//                           .where((element) => element.text.contains("Name:"))
//                           .first
//                           .text ??
//                       "Not Found";
//                   setState(() {});
//                   // now we can feed the input image into text recognition process
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             // Text(name?.substring(5).toString() ?? 'Name Is Goes Here'),
//             Center(
//               child: Text(
//                 name ?? 'Name Is Goes Here',
//                 style:
//                     const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
