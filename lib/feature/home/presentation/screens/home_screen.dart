// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iwalker/core/themes/text_extensions.dart';
// import 'package:iwalker/feature/others/presentation/screens/notification_screen.dart';
// import 'package:iwalker/feature/profile/controllers/profile_controller.dart';
// import 'package:iwalker/feature/profile/presentation/screens/user_profile_screen.dart';
// import 'package:iwalker/feature/task/controllers/task_controller.dart';
// import '../../../../core/widgets/default_circular_percent_widget.dart';
// import '../widgets/task_widget_home.dart';
// import 'package:intl/intl.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     Get.find<ProfileController>().getUserById();
//     Get.find<TaskController>().getAllTasks();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String today = DateFormat('d MMMM').format(DateTime.now());

//     return ColoredBox(
//       color: Color(0xff438B92),
//       child: SafeArea(
//         child: Scaffold(
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GetBuilder<ProfileController>(
//                     builder: (profileController) {
//                       return Container(
//                         padding: const EdgeInsets.all(16),
//                         height: 100,
//                         width: double.infinity,

//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4),
//                           color: Color(0xffC5DBDD),
//                         ),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               child: CircleAvatar(
//                                 radius: 30,
//                                 backgroundImage: NetworkImage(
//                                   profileController
//                                           .getUserByIdResponseModel
//                                           .userforProfile!
//                                           .avatar ??
//                                       'https://via.placeholder.com/150',
//                                 ), // Placeholder image
//                                 // AssetImage(
//                                 //   'assets/images/person.png',
//                                 // ),
//                               ),
//                               onTap: () {
//                                 Get.to(UserProfileScreen());
//                               },
//                             ),

//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 16.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         profileController
//                                                 .getUserByIdResponseModel
//                                                 .userforProfile!
//                                                 .name
//                                                 ?.text18Black() ??
//                                             'Mr. User Name'.text18Black(),
//                                         const SizedBox(height: 4),
//                                         "Today, $today".text16Grey(),
//                                       ],
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         Get.to(NotificationScreen());
//                                       },
//                                       icon: Icon(
//                                         Icons.notifications_active_outlined,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 16.0),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     height: 150,
//                     width: double.infinity,

//                     decoration: BoxDecoration(
//                       color: Color(0xffC366F75),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             'Today\'s Task'.text24White(),
//                             '3/8 Tasks'.text16White(),
//                           ],
//                         ),
//                         CircularPercentWidget(
//                           percent: 60,
//                           size: 100,
//                           fontColor: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),

//                   'In Progress'.text20Black(),
//                   const SizedBox(height: 16.0),

//                   //....................................................when api integration nedd to be raw code here .............................................................
//                   GetBuilder<TaskController>(
//                     builder: (taskController) {
//                       if (taskController
//                           .getAllTasksResponseModel
//                           .data!
//                           .isEmpty) {
//                         print('task is empty');
//                         return Container(
//                           height: 100,
//                           width: double.infinity,
//                           child: const Center(child: Text('No Task Found')),
//                         );
//                       }
//                       if (taskController.getAllTasksResponseModel.data! ==
//                           null) {
//                         print('TAsk is null');
//                         return Center(
//                           child: const Center(
//                             child: Text(
//                               textAlign: TextAlign.center,
//                               'No Task Found',
//                             ),
//                           ),
//                         );
//                       }
//                       return !taskController.getAllTasksIsLoading
//                           ? ListView.builder(
//                             shrinkWrap: true,
//                             itemCount:
//                                 taskController
//                                     .getAllTasksResponseModel
//                                     .data!
//                                     .length,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               var item =
//                                   taskController
//                                       .getAllTasksResponseModel
//                                       .data![index];
//                               return Padding(
//                                 padding: const EdgeInsets.only(
//                                   // left: 16.0,
//                                   // right: 16.0,
//                                   bottom: 16.0,
//                                 ),
//                                 child: TaskWidgetHome(
//                                   taskName: item.name ?? 'Name',
//                                   taskDate: item.date ?? 'Date',
//                                   taskStartTime: item.startTime ?? 'Start Time',
//                                   taskEndTime: item.endTime ?? 'End Time',
//                                   taskLocation: item.location ?? 'Location',
//                                   isFullDay: item.isFullDay ?? false,
//                                   taskId: item.sId!,
//                                 ),
//                               );
//                             },
//                           )
//                           : Center(child: CircularProgressIndicator());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
