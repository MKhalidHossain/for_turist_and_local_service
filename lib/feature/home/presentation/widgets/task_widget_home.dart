// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/utils.dart';
// import 'package:iwalker/core/themes/text_extensions.dart';
// import 'package:iwalker/feature/task/presentation/screens/create_new_task_or_edit_task.dart';
// import 'package:iwalker/feature/task/presentation/screens/task_details_screen.dart';

// import '../../../../core/widgets/default_circular_percent_widget.dart';
// import '../../../../core/widgets/linear_percent_bar_widget.dart';
// import '../../../../core/widgets/normal_custom_button.dart';

// class TaskWidgetHome extends StatelessWidget {


//    final String taskName;
//   final String taskDate;
//   final String taskStartTime;
//   final String taskEndTime;
//   final String taskLocation;
//   final bool isFullDay;
//     final String taskId;

//   const TaskWidgetHome({super.key, 
//   required this.taskName,
//   required this.taskDate, 
//   required this.taskStartTime,
//   required this.taskEndTime, 
//   required this.taskLocation, 
//   required this.isFullDay,
//   required this.taskId,
//     });


//   //   //
//   //   //required need to call Khalid vai to add this
//   //   //
//   //final String timeRemaining;
//   //   //final double percentComplete;
//   //   //final bool isFullDay;
//   //   //final bool notificationEnabled;
//   //   final String createdAt;
//   //   final String updatedAt;
//   //   final String taskId;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(TaskDetailsScreen(taskName: taskName, taskDate: taskDate, taskStartTime: taskStartTime, taskEndTime: taskEndTime, taskLocation: taskLocation, isFullDay: isFullDay, taskId: taskId));
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         height: 150,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Color(0xffC5DBDD),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 taskName.text20Black(),
//                 Row(
//                   children: [
//                     Icon(Icons.alarm, color: Colors.black),
//                     const SizedBox(width: 8),
//                     '$taskStartTime - $taskEndTime'.text16Black(),
//                   ],
//                 ),
//                 'Time Remaining'.text16Black(),
//                 LinearPercentBarWidget(percent: 50),
//               ],
//             ),

//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularPercentWidget(percent: 50, size: 70),
//                 const SizedBox(height: 16),
//                 NormalCustomButton(
//                   text: 'Edit',
//                   showIcon: true,
//                   sufixIcon: Icons.edit_outlined,
//                   onPressed: () {
//                     Get.to(
//                       CreateNewTaskOrEditTask(
//                         isEditing: true,
//                         taskId: taskId, // if needed for update
//                         existingTaskName: taskName,
//                         existingDate: taskDate,
//                         existingStartTime: taskStartTime,
//                         existingEndTime: taskEndTime,
//                         existingLocation: taskLocation,
//                         existingIsFullDay: isFullDay,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
