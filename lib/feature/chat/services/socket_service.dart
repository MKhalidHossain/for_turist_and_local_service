// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../core/constants/urls.dart';
// import '../../../../utils/app_constants.dart';
// import '../../profile/controllers/profile_controller.dart';
// import '../domain/models/get_user_associated_with_chat_response_model.dart';

// class SocketService extends GetxService {
//   static SocketService get instance => Get.find<SocketService>();
  
//   late IO.Socket _socket;
//   late ProfileController profileController;

//   bool _isConnected = false;
//   bool _isConnecting = false;
//   String? _currentUserId;
//   Timer? _reconnectTimer;
//   int _reconnectAttempts = 0;
//   static const int maxReconnectAttempts = 5;
//   static const Duration reconnectDelay = Duration(seconds: 3);

//   // Stream controllers for real-time updates
//   final StreamController<ChatData> _messageController = StreamController<ChatData>.broadcast();
//   final StreamController<Map<String, dynamic>> _userStatusController = StreamController<Map<String, dynamic>>.broadcast();
//   final StreamController<Map<String, dynamic>> _typingController = StreamController<Map<String, dynamic>>.broadcast();
//   final StreamController<List<ChatData>> _chatListController = StreamController<List<ChatData>>.broadcast();
//   final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

//   // Getters for streams
//   Stream<ChatData> get messageStream => _messageController.stream;
//   Stream<Map<String, dynamic>> get userStatusStream => _userStatusController.stream;
//   Stream<Map<String, dynamic>> get typingStream => _typingController.stream;
//   Stream<List<ChatData>> get chatListStream => _chatListController.stream;
//   Stream<bool> get connectionStream => _connectionController.stream;

//   // Getters for connection status
//   bool get isConnected => _isConnected;
//   bool get isConnecting => _isConnecting;

//   @override
//   void onInit() {
//     super.onInit();
    
//     _initializeSocket();
//   }

//   void _initializeSocket() async {
//     profileController = Get.find<ProfileController>();
//     _currentUserId = "68c000496f157e71e8d805d3"; 

//     try {
//       // Extract socket URL from base URL
//       // final socketUrl = Urls.baseUrl.replaceAll('/api/v1', '');
//       final socketUrl = "ws://10.10.5.95:5001";
      
//       _socket = IO.io(socketUrl, IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setTimeout(20000)
//           .setReconnectionDelay(3000)
//           .setReconnectionAttempts(maxReconnectAttempts)
//           .enableAutoConnect()
//           .build());

//       _setupSocketListeners();
//     } catch (e) {
//       debugPrint('Error initializing socket: $e');
//     }
//   }

//   void _setupSocketListeners() {
//     _socket.onConnect((_) {
//       debugPrint('✅ Socket connected successfully');
//       _isConnected = true;
//       _isConnecting = false;
//       _reconnectAttempts = 0;
//       _connectionController.add(true);
      
//       // Join user room if we have a user ID
//       // if (_currentUserId != null) {
//       //   // _joinUserRoom(_currentUserId!);
//       // }

//     print("Current User ID: $_currentUserId");

//       _socket.emit("join", _currentUserId);

//     _socket.on("message-received", (data) {
//           debugPrint('📨 Message received: $data');
//         });
//     });

//     _socket.onConnectError((error) {
//       debugPrint('❌ Socket connection error: $error');
//       _isConnected = false;
//       _isConnecting = false;
//       _connectionController.add(false);
//       _scheduleReconnect();
//     });

//     _socket.onDisconnect((_) {
//       debugPrint('⚠️ Socket disconnected');
//       _isConnected = false;
//       _connectionController.add(false);
//       _scheduleReconnect();
//     });

//     _socket.onError((error) {
//       debugPrint('❌ Socket error: $error');
//       _isConnected = false;
//       _connectionController.add(false);
//     });

    

//     // Message events
//     _socket.on('message-received', (data) {
//       debugPrint('📨 New message received: $data');
//       _handleNewMessage(data);
//     });


//     //////// End of Message events ////////

//     _socket.on('message-sent', (data) {
//       debugPrint('📤 Message sent confirmation: $data');
//       _handleMessageSent(data);
//     });

//     _socket.on('message-delivered', (data) {
//       debugPrint('📬 Message delivered: $data');
//       _handleMessageDelivered(data);
//     });

//     _socket.on('message-read', (data) {
//       debugPrint('👁️ Message read: $data');
//       _handleMessageRead(data);
//     });

//     // User status events
//     _socket.on('user-online', (data) {
//       debugPrint('🟢 User online: $data');
//       _userStatusController.add({
//         'userId': data['userId'],
//         'status': 'online',
//         'timestamp': DateTime.now().toIso8601String(),
//       });
//     });

//     _socket.on('user-offline', (data) {
//       debugPrint('🔴 User offline: $data');
//       _userStatusController.add({
//         'userId': data['userId'],
//         'status': 'offline',
//         'timestamp': data['lastSeen'] ?? DateTime.now().toIso8601String(),
//       });
//     });

//     // Typing events
//     _socket.on('user-typing', (data) {
//       debugPrint('⌨️ User typing: $data');
//       _typingController.add(data);
//     });

//     _socket.on('user-stopped-typing', (data) {
//       debugPrint('⌨️ User stopped typing: $data');
//       _typingController.add(data);
//     });

//     // Chat list updates
//     _socket.on('chat-list-updated', (data) {
//       debugPrint('📋 Chat list updated: $data');
//       _handleChatListUpdate(data);
//     });

//     // Room events
//     _socket.on('joined-room', (data) {
//       debugPrint('🚪 Joined room: $data');
//     });

//     _socket.on('left-room', (data) {
//       debugPrint('🚪 Left room: $data');
//     });
//   }

//   void _scheduleReconnect() {
//     if (_reconnectAttempts >= maxReconnectAttempts) {
//       debugPrint('❌ Max reconnection attempts reached');
//       return;
//     }

//     _reconnectTimer?.cancel();
//     _reconnectTimer = Timer(reconnectDelay, () {
//       if (!_isConnected && !_isConnecting) {
//         _reconnectAttempts++;
//         debugPrint('🔄 Attempting to reconnect... (${_reconnectAttempts}/$maxReconnectAttempts)');
//         _isConnecting = true;
//         _socket.connect();
//       }
//     });
//   }

//   Future<void> connect(String userId) async {
//     try {
//       _currentUserId = userId;
      
//       // if (_isConnected) {
//       //   // _joinUserRoom(userId);
//       //   return;
//       // }

//       if (_isConnecting) {
//         return;
//       }

//       _isConnecting = true;
//       _socket.connect();
//     } catch (e) {
//       debugPrint('Error connecting socket: $e');
//       _isConnecting = false;
//     }
//   }

//   void disconnect() {
//     try {
//       _reconnectTimer?.cancel();
//       _socket.disconnect();
//       _isConnected = false;
//       _isConnecting = false;
//       _currentUserId = null;
//       _connectionController.add(false);
//     } catch (e) {
//       debugPrint('Error disconnecting socket: $e');
//     }
//   }

//   // void _joinUserRoom(String userId) {
//   //   if (_isConnected) {
//   //     _socket.emit('join-user-room', {'userId': userId});
//   //   }
//   // }

//   // void joinChatRoom(String userId, String receiverId) {
//   //   if (_isConnected) {
//   //     _socket.emit('join', receiverId
//   //     // {
//   //     //   // 'chatId': chatId,
//   //     //   // 'receiverId': receiverId,
//   //     //   'userId': _currentUserId,
//   //     // }
//   //     );
//   //   }
//   // }

//   void leaveChatRoom(String chatId) {
//     if (_isConnected) {
//       _socket.emit('leave-chat-room', {'chatId': chatId});
//     }
//   }

//   // void sendMessage({
//   //   required String receiverId,
//   //   required String message,
//   //   String? messageType,
//   //   String? fileUrl,
//   //   String? fileType,
//   // }) {
//   //   if (!_isConnected) {
//   //     debugPrint('❌ Cannot send message: Socket not connected');
//   //     return;
//   //   }

//   //   if (_currentUserId == null) {
//   //     debugPrint('❌ Cannot send message: Current user ID is null');
//   //     return;
//   //   }

//   //   final messageData = {
//   //     'senderId': _currentUserId,
//   //     'receiverId': receiverId,
//   //     'message': message,
//   //     'messageType': messageType ?? 'text',
//   //     'fileUrl': fileUrl,
//   //     'fileType': fileType,
//   //     'timestamp': DateTime.now().toIso8601String(),
//   //   };

//   //   debugPrint('📤 Sending LIVE message: $messageData');
//   //   debugPrint('🔌 Socket connected: $_isConnected');
//   //   debugPrint('👤 Current user: $_currentUserId');
//   //   debugPrint('👥 Receiver: $receiverId');
    
//   //   // _socket.emit('message-received', {
//   //   //   'receiverId': receiverId,
//   //   //   'message': message,
//   //   // });

    
//   //   // // Also emit to room for better reliability
//   //   // final roomId = '${_currentUserId}_$receiverId';
//   //   // _socket.emit('room-message', {
//   //   //   ...messageData,
//   //   //   'roomId': roomId,
//   //   // });
//   // }

//   void sendTypingIndicator(String receiverId, bool isTyping) {
//     if (!_isConnected) return;

//     _socket.emit('typing', {
//       'receiverId': receiverId,
//       'isTyping': isTyping,
//       'userId': _currentUserId,
//     });
//   }

//   void markMessageAsRead(String messageId, String senderId) {
//     if (!_isConnected) return;

//     _socket.emit('mark-message-read', {
//       'messageId': messageId,
//       'senderId': senderId,
//       'userId': _currentUserId,
//     });
//   }

//   void requestChatList() {
//     if (!_isConnected) return;

//     _socket.emit('get-chat-list', {'userId': _currentUserId});
//   }

//   void _handleNewMessage(dynamic data) {
//     try {
//       if (data is Map<String, dynamic>) {
//         debugPrint('📨 Processing new message: $data');
//         final chatData = ChatData.fromJson(data);
//         _messageController.add(chatData);
//         debugPrint('✅ Message added to stream successfully');
//       }
//     } catch (e) {
//       debugPrint('❌ Error handling new message: $e');
//     }
//   }

//   void _handleMessageSent(dynamic data) {
//     // Handle message sent confirmation
//     debugPrint('Message sent confirmation received');
//   }

//   void _handleMessageDelivered(dynamic data) {
//     // Handle message delivered confirmation
//     debugPrint('Message delivered confirmation received');
//   }

//   void _handleMessageRead(dynamic data) {
//     // Handle message read confirmation
//     debugPrint('Message read confirmation received');
//   }

//   void _handleChatListUpdate(dynamic data) {
//     try {
//       if (data is Map<String, dynamic> && data['data'] is List) {
//         final chatList = (data['data'] as List)
//             .map((e) => ChatData.fromJson(e))
//             .toList();
//         _chatListController.add(chatList);
//       }
//     } catch (e) {
//       debugPrint('Error handling chat list update: $e');
//     }
//   }

//   // Method to get current user ID from SharedPreferences
//   Future<String?> getCurrentUserId() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString(AppConstants.token);
//     } catch (e) {
//       debugPrint('Error getting current user ID: $e');
//       return null;
//     }
//   }

//   // Method to refresh chat list
//   Future<void> refreshChatList() async {
//     if (_isConnected) {
//       requestChatList();
//     }
//   }

//   // Method to get user online status
//   void getUserStatus(String userId) {
//     if (_isConnected) {
//       _socket.emit('get-user-status', {'userId': userId});
//     }
//   }

//   @override
//   void onClose() {
//     _reconnectTimer?.cancel();
//     _messageController.close();
//     _userStatusController.close();
//     _typingController.close();
//     _chatListController.close();
//     _connectionController.close();
//     _socket.dispose();
//     super.onClose();
//   }
// }
