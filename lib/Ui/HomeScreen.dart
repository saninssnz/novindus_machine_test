// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:novindus_machine_test/Provider/Provider.dart';
// import 'package:novindus_machine_test/Utils/ArrowIndicator.dart';
// import 'package:provider/provider.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//
//   @override
//   void initState() {
//     Provider.of<DataProvider>(context, listen: false).getCategories(context);
//
//     tabController?.addListener(_handleTabSelection);
//
//     super.initState();
//   }
//
//   void _handleTabSelection() {
//     if (tabController!.indexIsChanging) {
//       if(tabController!.index == 0){
//         Provider.of<DataProvider>(context, listen: false).getCategoryData(context,tabController);
//       }
//     }
//   }
//
//
//   @override
//   void dispose() {
//     tabController!.dispose();
//     super.dispose();
//   }
//
//   TabController? tabController;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataProvider>(builder: (context, dataProvider, child)
//     {
//       return DefaultTabController(
//         length: dataProvider.newsCategoryList.length,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             title: Text("News & Blogs",style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black
//             ),),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(kToolbarHeight),
//               child: Container(
//                 height: 50,
//                 alignment: Alignment.center,
//                 child: TabBar(
//                 isScrollable: true,
//                   controller: tabController,
//                   labelColor: Colors.green,
//                   unselectedLabelColor: Colors.black,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicator: ArrowTabBarIndicator(),
//                   tabs: dataProvider.newsCategoryList.map((e) => Tab(text: e.name)).toList(),
//                 ),
//               ),
//             ),
//           ),
//
//         ),
//       );
//     }
//     );
//     }
//   }
