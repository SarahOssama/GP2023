// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapView extends StatefulWidget {
//   MapView({Key? key}) : super(key: key);

//   @override
//   State<MapView> createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   late GoogleMapController googleMapController;
//   List<Marker> markers = [];
//   bool showMaps = true;
//   @override
//   void initState() {
//     markers.add(
//       Marker(
//         markerId: MarkerId("TmicoLocation"),
//         position: LatLng(30.0188089, 31.2248912),
//       ),
//     );
//     if (markers.isNotEmpty) {
//       setState(() {
//         showMaps = true;
//       });
//     }
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: showMaps
//           ? GoogleMap(
//               onMapCreated: (controller) {
//                 setState(() {
//                   googleMapController = controller;
//                 });
//               },
//               markers: Set<Marker>.of(markers),
//               mapType: MapType.terrain,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(30.0188089, 31.2248912),
//               ),
//             )
//           : CircularProgressIndicator(
//               color: Colors.black,
//             ),
//     );
//   }
// }

























// // import 'package:flutter/material.dart';
// // import 'package:google_maps/google_maps.dart' as jsMap;
// // import 'dart:ui' as ui;
// // import 'dart:html';

// // class GoogleMap extends StatelessWidget {
// //   const GoogleMap({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     String htmlId = "7";
// //     // ignore: undefined_prefixed_name
// //     ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
// //       final myLatlng = jsMap.LatLng(30.0188089, 31.2248912);
// //       final mapOptions = jsMap.MapOptions()
// //         ..zoom = 10
// //         ..center = jsMap.LatLng(30.0188089, 31.2248912);
// //       final elem = DivElement()
// //         ..id = htmlId
// //         ..style.width = "100%"
// //         ..style.height = "100%"
// //         ..style.border = 'none';
// //       final map = jsMap.GMap(elem, mapOptions);
// //       jsMap.Marker(jsMap.MarkerOptions()
// //         ..position = myLatlng
// //         ..map = map
// //         ..title = "hello world");
// //       return elem;
// //     });
// //     return HtmlElementView(viewType: htmlId);
// //   }
// // }
