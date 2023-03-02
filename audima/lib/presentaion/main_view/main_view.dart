// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shrink_sidemenu/shrink_sidemenu.dart';
// import 'package:tmico/presentaion/presentation_widgets.dart';
// import 'package:tmico/responsive.dart';

// class MainView extends StatefulWidget {
//   final Widget bodyView;
//   final GlobalKey<SideMenuState> sideMenuKey;
//   final int index;
//   const MainView(
//       {super.key,
//       required this.bodyView,
//       required this.index,
//       required this.sideMenuKey});
//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView>
//     with SingleTickerProviderStateMixin {
//   // Controllers
//   late TabController tabController;
//   late ScrollController scrollController;
//   @override
//   void initState() {
//     tabController =
//         TabController(length: 4, vsync: this, initialIndex: widget.index);
//     scrollController = ScrollController(initialScrollOffset: 0);
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(MainView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     tabController.index = widget.index;
//   }

//   Widget buildMenu() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ListTile(
//           onTap: () {
//             context.go('/home');
//           },
//           leading: const Icon(Icons.home, size: 25.0, color: Colors.white),
//           title: Text(
//             "Home",
//             style: ResponsiveTextStyles.navigationDrawerTextsStyles(context),
//           ),
//           textColor: Colors.white,
//           dense: true,
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         ListTile(
//           onTap: () {
//             context.go('/products');
//           },
//           leading: const Icon(Icons.production_quantity_limits,
//               size: 25.0, color: Colors.white),
//           title: Text(
//             "Products",
//             style: ResponsiveTextStyles.navigationDrawerTextsStyles(context),
//           ),
//           textColor: Colors.white,
//           dense: true,

//           // padding: EdgeInsets.zero,
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         ListTile(
//           onTap: () {
//             context.go('/aboutUs');
//           },
//           leading: const Icon(FontAwesomeIcons.info,
//               size: 25.0, color: Colors.white),
//           title: Text(
//             "AboutUs",
//             style: ResponsiveTextStyles.navigationDrawerTextsStyles(context),
//           ),
//           textColor: Colors.white,
//           dense: true,

//           // padding: EdgeInsets.zero,
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         ListTile(
//           onTap: () {
//             context.go('/contactUs');
//           },
//           leading:
//               const Icon(Icons.contact_mail, size: 25.0, color: Colors.white),
//           title: Text(
//             "ContactUs",
//             style: ResponsiveTextStyles.navigationDrawerTextsStyles(context),
//           ),
//           textColor: Colors.white,
//           dense: true,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SideMenu(
//       background: Colors.black.withOpacity(0.91),
//       key: widget.sideMenuKey,
//       menu: Center(child: buildMenu()),
//       inverse: true,
//       type: SideMenuType.shrinkNSlide,
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           automaticallyImplyLeading: false,
//           title: mainTabBar(
//               context, Colors.black, tabController, widget.sideMenuKey),
//         ),
//         body: widget.bodyView,
//       ),
//     );
//   }
// }
