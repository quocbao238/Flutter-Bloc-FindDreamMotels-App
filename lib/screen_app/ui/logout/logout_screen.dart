
// import 'package:findingmotels/config_app/sizeScreen.dart';
// import 'package:findingmotels/screen_app/custom_widget/clip_path_custom/registerClipPath.dart';
// import 'package:findingmotels/screen_app/ui/login/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class LogOutPage extends StatefulWidget {
//   @override
//   _LogOutPageState createState() => _LogOutPageState();
// }

// class _LogOutPageState extends State<LogOutPage> {
//   String imageUrl = 'assets/logoutSvg.svg';

//   @override
//   Widget build(BuildContext context) {
//     getSizeApp(context);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(211, 220, 240, 1),
//       body: Stack(
//         children: <Widget>[
//           buildBackground(Size.getHeight),
//           buildPageView(Size.getHeight, Size.getWidth),
//         ],
//       ),
//     );
//   }

//   Widget buildPageView(double height, double width) {
//     return Positioned.fill(
//       child: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(top: 16),
//             color: Colors.transparent,
//             height: height * 0.6,
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: (Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 SafeArea(
//                   child: Container(
//                     child: Center(
//                       child: Text(
//                         "See you again!",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 2.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SvgPicture.asset(
//                     imageUrl,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//               ],
//             )),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(bottom: height * 0.04),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   buildContinueNow(width, height),
//                   SizedBox(height: 16.0),
//                   buildLoginFacebook(width, height),
//                   buildLoginText(height)
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildLoginText(double height) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => LoginPage()));
//       },
//       child: Container(
//         margin: EdgeInsets.only(top: height * 0.03),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Continue via Email/Phone Number",
//               style: StyleText.subhead18Black500
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildContinueNow(double width, double height) {
//     return Container(
//       width: width * 0.75,
//       height: height * 0.08,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         color: Colors.red[300],
//       ),
//       padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             width: 25,
//             height: 25,
//             child: Image.asset(
//               'assets/googleIcon.png',
//               fit: BoxFit.fill,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text("Continue on Google", style: StyleText.header20White),
//         ],
//       ),
//     );
//   }

//   Widget buildLoginFacebook(double width, double height) {
//     return Container(
//       width: width * 0.75,
//       height: height * 0.08,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         color: Color.fromRGBO(81, 134, 234, 1),
//       ),
//       padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             width: 30,
//             height: 30,
//             child: Image.asset(
//               'assets/facebookWhiteIcon.png',
//               fit: BoxFit.fill,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text("Continue on Facebook", style: StyleText.header20White)
//         ],
//       ),
//     );
//   }

//   Widget buildBackground(double height) {
//     return Positioned.fill(
//       child: AnimatedContainer(
//         height: height * 0.8,
//         duration: Duration(milliseconds: 10000),
//         curve: Curves.ease,
//         child: ClipPath(
//           child: Container(
//             color: Color.fromRGBO(9, 92, 113, 1),
//           ),
//           clipper: RegisterClipPath(),
//         ),
//       ),
//     );
//   }
// }
