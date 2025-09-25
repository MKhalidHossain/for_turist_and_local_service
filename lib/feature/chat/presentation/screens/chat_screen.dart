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
  final String? messageId;
  final String? senderId;
  final String? receiverId;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.messageId,
    this.senderId,
    this.receiverId,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    return ChatMessage(
      text: json['message'] ?? '',
      isSentByMe: json['senderId'] == currentUserId,
      time: json['time'] ?? DateTime.now().toIso8601String(),
      messageId: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
    );
  }
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

  // List to hold all messages (both historical and real-time)
  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  ScrollController _scrollController = ScrollController();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.token);
  }

  void _setupSocketListeners(String currentUserId) {
    // Listen for new messages
    _socket.on('message-received', (data) {
      print('New message received: $data');

      if (data is Map<String, dynamic>) {
        final newMessage = ChatMessage.fromJson(data, currentUserId);

        // Only add if this message is relevant to current chat
        if (newMessage.senderId == widget.receiverIdForChat ||
            newMessage.receiverId == widget.receiverIdForChat) {
          setState(() {
            _messages.insert(
              0,
              newMessage,
            ); // Add to beginning (since we reverse)
          });

          // Auto-scroll to bottom
          _scrollToBottom();
        }
      }
    });

    // Listen for message delivery status
    _socket.on('new-message', (data) {
      print('Message delivered: $data');
      // You can update message status here if needed
    });

    // Listen for typing indicators
    _socket.on('user-typing', (data) {
      // Handle typing indicators if needed
      print('User typing: $data');
    });

    // Listen for user online status
    _socket.on('user-online', (data) {
      setState(() {
        isOnline = true;
      });
    });

    _socket.on('user-offline', (data) {
      setState(() {
        isOnline = false;
        lastSeen = "Just now";
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _loadInitialMessages() async {
    try {
      await homeController.getMessage(widget.receiverIdForChat!);

      final apiMessages =
          homeController.getMessagesPreviousResponseModel.data?.messages ?? [];

      setState(() {
        _messages =
            apiMessages.map((message) {
              return ChatMessage(
                text: message.message ?? '',
                isSentByMe:
                    message.senderId ==
                    profileController.getProfileResponseModel?.data?.sId,
                time: message.time ?? DateTime.now().toIso8601String(),
                messageId: message.senderId,
                senderId: message.senderId,
                receiverId: message.receiverId,
              );
            }).toList();

        _isLoading = false;
      });

      // Scroll to bottom after loading messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      print('Error loading messages: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  _connectSocket(String currentUserId) {
    _socket.onConnect((data) {
      print('Connection established');

      // Join the chat room
      _socket.emit('join-chat', {
        'userId': currentUserId,
        'receiverId': widget.receiverIdForChat,
      });

      // Setup listeners after connection
      _setupSocketListeners(currentUserId);
    });

    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server Disconnected'));
    _socket.onError((data) => print('Socket Error: $data'));
  }

  @override
  void initState() {
    super.initState();

    homeController = Get.find<HomeController>();
    profileController = Get.find<ProfileController>();
    _messageController = TextEditingController();
    _scrollController = ScrollController();

    // Initialize socket connection
    getToken().then((token) {
      final currentUserId =
          profileController.getProfileResponseModel?.data?.sId;

      if (currentUserId == null) {
        print('Error: Current user ID is null');
        return;
      }

      _socket = IO.io(
        'ws://localhost:5001',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'Authorization': token})
            .setTimeout(5000)
            .build(),
      );

      _connectSocket(currentUserId);
      _socket.connect();
    });

    // Load initial messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialMessages();
    });
  }

  void sendMessage() {
    if (_messageController.text.isEmpty || _isSending) return;

    final currentUserId = profileController.getProfileResponseModel?.data?.sId;
    if (currentUserId == null) return;

    setState(() {
      _isSending = true;
    });

    // Create temporary message (will be replaced when server confirms)
    final tempMessage = ChatMessage(
      text: _messageController.text,
      isSentByMe: true,
      time: DateTime.now().toIso8601String(),
      messageId: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUserId,
      receiverId: widget.receiverIdForChat,
    );

    // Add temporary message immediately for instant feedback
    setState(() {
      _messages.insert(0, tempMessage);
    });

    _scrollToBottom();

    final payload = {
      "userId": currentUserId,
      "receiverId": widget.receiverIdForChat,
      "message": _messageController.text,
      "time": DateTime.now().toIso8601String(),
    };

    print("Sending message payload: $payload");

    // Emit message via socket
    _socket.emit('message-received', payload);

    // Also send via HTTP API as backup
    homeController.sendMessage(
      widget.receiverIdForChat!,
      _messageController.text,
    );

    _messageController.clear();

    setState(() {
      _isSending = false;
    });
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      sendMessage();
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String formatChatTime(String isoString) {
    try {
      DateTime utcTime = DateTime.parse(isoString).toLocal();
      return DateFormat.jm().format(utcTime);
    } catch (e) {
      return DateFormat.jm().format(DateTime.now());
    }
  }

  Widget _buildMessageBubble(ChatMessage message, bool isNewSender, int index) {
    final size = MediaQuery.of(context).size;
    final isMe = message.isSentByMe;

    return Padding(
      padding: EdgeInsets.only(top: isNewSender ? 20 : 12),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                  loadingBuilder: (context, child, loadingProgress) {
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
          if (!isMe) const SizedBox(width: 8),

          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: isMe ? Color(0xFFFF4B5C) : Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatChatTime(message.time),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: isMe ? Colors.white70 : Colors.black54,
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
                  profileController
                          .getProfileResponseModel
                          ?.data
                          ?.profileImage ??
                      '',
                  width: size.width * 0.08,
                  height: size.width * 0.08,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                      loadingBuilder: (context, child, loadingProgress) {
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
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Messages List
            Expanded(
              child:
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _messages.isEmpty
                      ? Center(
                        child: Text(
                          'No messages yet\nStart the conversation!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        padding: EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];

                          // Check if this is a new sender group
                          bool isNewSender = index == _messages.length - 1;
                          if (index < _messages.length - 1) {
                            final nextMessage = _messages[index + 1];
                            isNewSender =
                                message.isSentByMe != nextMessage.isSentByMe;
                          }

                          return _buildMessageBubble(
                            message,
                            isNewSender,
                            index,
                          );
                        },
                      ),
            ),

            // Message Input
            Divider(height: 1),
            _buildMessageInput(),
          ],
        ),
      ),
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
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 14),
              onSubmitted: (_) => _handleSendMessage(),
              onChanged: (text) {
                // You can implement typing indicator here
                if (text.isNotEmpty) {
                  _socket.emit('typing', {
                    'userId':
                        profileController.getProfileResponseModel?.data?.sId,
                    'receiverId': widget.receiverIdForChat,
                    'isTyping': true,
                  });
                }
              },
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
            decoration: BoxDecoration(
              color: _isSending ? Colors.grey : Color(0xFFFF4B5C),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon:
                  _isSending
                      ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                      : Icon(Icons.send, size: 18, color: Colors.white),
              onPressed: _isSending ? null : _handleSendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
