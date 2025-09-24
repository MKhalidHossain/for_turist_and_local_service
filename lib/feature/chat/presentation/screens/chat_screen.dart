import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/app_constants.dart';

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}

bool isOnline = false;
String lastSeen = "5 min ago";

class ChatScreen extends StatefulWidget {
  final String? receiverIdForChat;
  final String? userReceiverNameForChat;
  final String? userReceiverImageForChat;
  final String? userSenderImageForChat;

  ChatScreen({
    super.key,
    this.receiverIdForChat,
    this.userReceiverNameForChat,
    this.userReceiverImageForChat,
    this.userSenderImageForChat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late HomeController homeController;
  late ProfileController profileController;
  late TextEditingController _messageController;
  late IO.Socket _socket;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.token);
  }

  _connectSocket() {
    _socket.onConnect((data) => print('connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO sever Disconnected'));
  }

  @override
  void initState() {
    super.initState();
    getToken().then((token) {
      _socket = IO.io(
        // 'http://localhost:5001',
        'http://localhost:5001',
      //  'http://10.0.2.2:5001',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'Authorization': token})
            .setTimeout(5000)
            // .setQuery({'userId': widget.receiverIdForChat})
            .build(),
      );
      _connectSocket();
      _socket.connect();
    });

    homeController = Get.find<HomeController>();
    profileController = Get.find<ProfileController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getMessage(widget.receiverIdForChat!);
      profileController.getUserProfile();
    });
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _socket.dispose();
    _messageController.dispose();
  }

  // final List<ChatMessage> messages = [
  //   ChatMessage(
  //     text: "Hi there! How can I help you?",
  //     isSentByMe: false,
  //     time: "10:32 AM",
  //   ),
  //   ChatMessage(
  //     text: "Hi! I’m interested in your City Tour.",
  //     isSentByMe: true,
  //     time: "10:32 AM",
  //   ),
  //   ChatMessage(
  //     text: "Great! When are you planning to visit China?",
  //     isSentByMe: false,
  //     time: "10:32 AM",
  //   ),
  //   ChatMessage(
  //     text: "Great! When are you planning to visit China?",
  //     isSentByMe: true,
  //     time: "10:32 AM",
  //   ),
  //   ChatMessage(
  //     text:
  //         "Perfect! I have availability on Tuesday and Wednesday. Would either of those days work for you?",
  //     isSentByMe: false,
  //     time: "10:32 AM",
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("userIdForChat: ${widget.receiverIdForChat}");

    return GetBuilder<HomeController>(
      builder: (homeController) {
        // print(
        //   " from chat Screen finding user id : ${homeController.getProfileResponseModel?.data?.sId}",
        // );
        print(
          "from chat Screen finding user id : ${homeController.getMessagesPreviousResponseModel.data?.messages?.first.message}",
        );

        final allDataMessages =
            homeController.getMessagesPreviousResponseModel.data;
        final senderProfile = profileController.getProfileResponseModel?.data;
        return homeController.isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
              backgroundColor: Colors.white,

              body: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButton(color: Colors.black),
                        CircleAvatar(
                          radius: size.width * 0.06,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: Image.network(
                              widget.userReceiverImageForChat ?? '',
                              width: size.width * 0.12,
                              height: size.width * 0.12,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;

                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/profileBlankImage.png",

                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   radius: 16,
                        //   backgroundImage: AssetImage('assets/images/user1.png'),
                        // ),
                        const SizedBox(width: 8),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userReceiverNameForChat ?? 'User Name',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                if (isOnline)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                Text(
                                  isOnline ? "Online" : "Last seen $lastSeen",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(16),
                        itemCount: allDataMessages?.messages?.length,
                        itemBuilder: (context, index) {
                          // final reversedIndex =
                          //     (allDataMessages!.messages!.length - 1) -
                          //     index; // 👈 reverse logic
                          final message = allDataMessages?.messages?[index];
                          final myUserId =
                              profileController
                                  .getProfileResponseModel
                                  ?.data
                                  ?.sId;

                          final isMe = message?.senderId == myUserId;
                          final isSentByMe = isMe;

                          // Check if the previous message is from a different sender
                          bool isNewSender = true;
                          if (index > 0) {
                            final prevMessage =
                                allDataMessages?.messages?[index - 1];
                            final prevIsSentByMe =
                                prevMessage?.receiverId ==
                                        widget.receiverIdForChat
                                    ? false
                                    : true;
                            isNewSender = prevIsSentByMe != isSentByMe;
                          }

                          return Padding(
                            padding: EdgeInsets.only(
                              top: isNewSender ? 20 : 12,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isMe)
                                  CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.grey[200],
                                    child: ClipOval(
                                      child: Image.network(
                                        widget.userReceiverImageForChat ?? '',
                                        width: size.width * 0.08,
                                        height: size.width * 0.08,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;

                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            "assets/images/profileBlankImage.png",

                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                // CircleAvatar(
                                //   radius: 14,
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user1.png',
                                //   ),
                                // ),
                                if (!isMe) const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isMe
                                              ? Color(0xFFFF4B5C)
                                              : Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          isMe
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message?.message ?? 'no message',
                                          style: TextStyle(
                                            color:
                                                isMe
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                        Text(
                                          formatChatTime(
                                            (message?.time) ?? '0.00',
                                          ),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                isMe
                                                    ? AppColors.context(
                                                      context,
                                                    ).backgroundColor
                                                    : AppColors
                                                        .primaryTextBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (isMe)
                                  CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.grey[200],
                                    child: ClipOval(
                                      child: Image.network(
                                        senderProfile?.profileImage ?? '',
                                        width: size.width * 0.08,
                                        height: size.width * 0.08,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;

                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            "assets/images/profileBlankImage.png",

                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                // CircleAvatar(
                                //   radius: 14,
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user2.png',
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(height: 53),
                    _buildMessageInput(),
                  ],
                ),
              ),
            );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.attach_file_outlined,
              color: AppColors.secondaryColor,
              size: 22,
            ),
            onPressed: () {
              // Handle file attachment
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondayText,
                ),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: AppColors.secondaryColor,
              size: 22,
            ),
            onPressed: () {
              // Handle emoji picker
            },
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFFF4B5C),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.send, size: 18, color: Colors.white),
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  homeController.sendMessage(
                    widget.receiverIdForChat!,
                    _messageController.text,
                  );
                  _messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
