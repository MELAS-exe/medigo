// import 'package:flutter/material.dart';
//
// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   bool _isCapturing = false;
//   bool _imageCaptured = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Camera viewfinder (simulated)
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               color: Colors.grey[900],
//               child: !_imageCaptured
//                   ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.camera_alt,
//                       size: 80,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Placez votre ordonnance\ndans le cadre",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//                   : Center(
//                 child: Container(
//                   width: 300,
//                   height: 400,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Photo capturée\n✓",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Camera frame overlay (only when not captured)
//             if (!_imageCaptured)
//               Center(
//                 child: Container(
//                   width: 320,
//                   height: 420,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.green,
//                       width: 3,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//             // Top bar
//             Positioned(
//               top: 20,
//               left: 20,
//               right: 20,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Back button
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                     ),
//                   ),
//
//                   // Title
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "Scanner Ordonnance",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//
//                   // Flash button
//                   GestureDetector(
//                     onTap: () {
//                       // Flash toggle
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.flash_off,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Bottom controls
//             Positioned(
//               bottom: 40,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: !_imageCaptured
//                     ? Center(
//                   // Capture button
//                   child: GestureDetector(
//                     onTap: _isCapturing ? null : _captureImage,
//                     child: Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: _isCapturing ? Colors.grey : Colors.green,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 4,
//                         ),
//                       ),
//                       child: _isCapturing
//                           ? Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                           : Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                         size: 40,
//                       ),
//                     ),
//                   ),
//                 )
//                     : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Retake button
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _imageCaptured = false;
//                         });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[700],
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Text(
//                           "Reprendre",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // Camera button (for another shot)
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//
//                     // Validate button
//                     GestureDetector(
//                       onTap: () {
//                         _validateImage();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Text(
//                           "Valider",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _captureImage() async {
//     setState(() {
//       _isCapturing = true;
//     });
//
//     // Simulate capture delay
//     await Future.delayed(Duration(milliseconds: 800));
//
//     setState(() {
//       _isCapturing = false;
//       _imageCaptured = true;
//     });
//   }
//
//   void _validateImage() {
//     // Handle image validation
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Photo validée !"),
//         backgroundColor: Colors.green,
//       ),
//     );
//
//     // Navigate back or to next screen
//     Navigator.pop(context);
//   }
// }