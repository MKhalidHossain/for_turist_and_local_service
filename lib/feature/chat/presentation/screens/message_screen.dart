import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';

import '../../../../core/constants/app_colors.dart';
import 'chat_screen.dart';

class MessageModel {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isRead;
  final bool isMedia;
  final bool isDocument;
  final bool isSentByMe;

  MessageModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unreadCount = 0,
    this.isRead = false,
    this.isMedia = false,
    this.isDocument = false,
    this.isSentByMe = false,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    homeController.getUserAssociatedWithChat();
  }

  @override
  Widget build(BuildContext context) {
    // final List<MessageModel> messages = [
    //   MessageModel(
    //     name: "Bessie Cooper",
    //     message: "Hello! Guys",
    //     time: "5:27 am",
    //     unreadCount: 2,
    //     avatar: 'assets/images/user1.png',
    //     isSentByMe: false,
    //   ),
    //   MessageModel(
    //     name: "Cody Fisher",
    //     message: "Hello! Guys",
    //     time: "Yesterday",
    //     avatar: 'assets/images/user2.png',
    //     isSentByMe: true,
    //     isRead: true,
    //   ),
    //   MessageModel(
    //     name: "Kathryn Murphy",
    //     message: "Photo",
    //     time: "20/03/2025",
    //     avatar: 'assets/images/user3.png',
    //     isMedia: true,
    //     isRead: true,
    //     isSentByMe: true,
    //   ),
    //   MessageModel(
    //     name: "Arlene McCoy",
    //     message: "Document.pdf (1 page)",
    //     time: "5:27 am",
    //     avatar: 'assets/images/user4.png',
    //     isDocument: true,
    //     isSentByMe: true,
    //   ),
    //   MessageModel(
    //     name: "Theresa Webb",
    //     message: "Hello! Guys",
    //     time: "5:27 am",
    //     unreadCount: 3,
    //     avatar: 'assets/images/user5.png',
    //     isSentByMe: false,
    //   ),
    //   MessageModel(
    //     name: "Ralph Edwards",
    //     message: "👍🏻👍🏻",
    //     time: "5:27 am",
    //     avatar: 'assets/images/user1.png',
    //     isSentByMe: true,
    //     isRead: true,
    //   ),
    //   MessageModel(
    //     name: "Cody Fisher",
    //     message: "Hello! Guys",
    //     time: "Yesterday",
    //     avatar: 'assets/images/user2.png',
    //     isSentByMe: true,
    //     isRead: true,
    //   ),
    //   MessageModel(
    //     name: "Kathryn Murphy",
    //     message: "Photo",
    //     time: "20/03/2025",
    //     avatar: 'assets/images/user3.png',
    //     isMedia: true,
    //     isRead: true,
    //     isSentByMe: true,
    //   ),
    //   MessageModel(
    //     name: "Arlene McCoy",
    //     message: "Document.pdf (1 page)",
    //     time: "5:27 am",
    //     avatar: 'assets/images/user4.png',
    //     isDocument: true,
    //     isSentByMe: true,
    //   ),
    //   MessageModel(
    //     name: "Theresa Webb",
    //     message: "Hello! Guys",
    //     time: "5:27 am",
    //     avatar: 'assets/images/user5.png',
    //     isSentByMe: false,
    //   ),
    // ];

    String formatChatTime(String isoString) {
      try {
        DateTime utcTime =
            DateTime.parse(isoString).toLocal(); // convert to local
        return DateFormat.jm().format(utcTime); // e.g., "5:27 AM"
      } catch (e) {
        return '';
      }
    }

    return GetBuilder<HomeController>(
      builder: (homeController) {
        print(
          "This is from message screen :${homeController.getUserAssociatedWithChatResponseModel.data?.first.name ?? 'No name'}",
        );
        // final receiverData =
        //     homeController.getUserAssociatedWithChatResponseModel.data;
        final messagesAll =
            homeController.getUserAssociatedWithChatResponseModel.data;

        return homeController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                elevation: 0,
                // leading: SizedBox(height: 40),
                // centerTitle: false,
                title: "Messages".text24Black(),
              ),
              body: ListView.builder(
                itemCount: messagesAll?.length,
                itemBuilder: (context, index) {
                  final message = messagesAll?[index];

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      child: ClipOval(
                        child: Image.network(
                          message?.avatar ?? "", // your avatar URL
                          fit: BoxFit.cover,
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/profileBlankImage.png", // placeholder asset
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            );
                          },
                        ),
                      ),
                    ),

                    title: Text(
                      message?.name ?? 'User',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        if ((message?.isSentByMe ?? false) &&
                            (message?.isMedia ?? false) &&
                            (message?.isDocument ?? false))
                          Icon(
                            (message?.isRead ?? false)
                                ? Icons.done_all
                                : Icons.check,
                            size: 16,
                            color:
                                (message?.isRead ?? false)
                                    ? Color(0XFFFF3951)
                                    : Colors.grey,
                          ),
                        if ((message?.isSentByMe ?? false) &&
                            (message?.isMedia ?? false) &&
                            (message?.isDocument ?? false))
                          const SizedBox(width: 4),
                        if ((message?.isMedia) ?? false)
                          const Icon(
                            Icons.photo,
                            size: 14,
                            color: Colors.black45,
                          ),
                        if ((message?.isDocument) ?? false)
                          const Icon(
                            Icons.insert_drive_file,
                            size: 14,
                            color: Colors.black45,
                          ),
                        if ((message?.isMedia ?? false) ||
                            (message?.isDocument ?? false))
                          const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            message?.message ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.secondayText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message?.time != null
                              ? formatChatTime((message?.time) ?? '0.00')
                              : '0.00',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                ((message?.isRead) ?? false)
                                    ? Colors.grey
                                    : Colors.black54,
                          ),
                        ),
                        if ((message?.unreadCount ?? 0) > 0)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              message!.unreadCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Get.to(
                        () => ChatScreen(
                          receiverIdForChat: message?.receiverId,
                          userReceiverNameForChat: message?.name ?? '',
                          userReceiverImageForChat: message?.avatar ?? '',
                        ),
                      );
                    },
                  );
                },
              ),
            );
      },
    );
  }
}
