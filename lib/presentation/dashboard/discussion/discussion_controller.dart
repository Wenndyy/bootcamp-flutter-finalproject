// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:finalproject/data/model/chat_item.dart';
import 'package:finalproject/data/repository/chat_repository.dart';

class DiscussionController extends GetxController {
  final ChatRepository _chatRepository;
  DiscussionController({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _chatTextController = TextEditingController();

  List<ChatDataItem> messages = List.empty(growable: true);
  final _isLoadingMessages = false.obs;
  final _selectedFile = Rx<XFile?>(null);

  bool get isLoadingMessages => _isLoadingMessages.value;
  XFile? get selectedFile => _selectedFile.value;
  ScrollController get scrollController => _scrollController;
  TextEditingController get chatTextController => _chatTextController;

  /* @override
  void onReady() async {
    super.onReady();
    await retrieveMessages;
  } */

  void createMessage({
    required bool isMe,
    required String message,
  }) {
    messages.add(ChatDataItem(
      name: 'Karina',
      message: message,
      time: DateTime.now(),
      isMe: isMe,
    ));
    update();
  }

  /*  Future<void> get retrieveMessages async {
    _isLoadingMessages.value = true;
    final values = await _chatRepository.messages;
    await Future.delayed(const Duration(seconds: 2));
    _messages.value = values;
    _isLoadingMessages.value = false;
  } */

  Future<void> openCamera() async {
    final cameraFile = await _picker.pickImage(source: ImageSource.camera);
    _selectedFile.value = cameraFile;
  }

  Future<void> openGallery() async {
    final galleryFile = await _picker.pickImage(source: ImageSource.gallery);
    _selectedFile.value = galleryFile;
  }

  //int get messageLength => _messages.value.length;
}

class ChatDataItem {
  final String name;
  final String message;
  final DateTime time;
  final bool isMe;
  ChatDataItem({
    required this.name,
    required this.message,
    required this.time,
    required this.isMe,
  });

  ChatDataItem copyWith({
    String? name,
    String? message,
    DateTime? time,
    bool? isMe,
  }) {
    return ChatDataItem(
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
      isMe: isMe ?? this.isMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'message': message,
      'time': time.millisecondsSinceEpoch,
      'isMe': isMe,
    };
  }

  factory ChatDataItem.fromMap(Map<String, dynamic> map) {
    return ChatDataItem(
      name: map['name'] as String,
      message: map['message'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      isMe: map['isMe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatDataItem.fromJson(String source) =>
      ChatDataItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatDataItem(name: $name, message: $message, time: $time, isMe: $isMe)';
  }

  @override
  bool operator ==(covariant ChatDataItem other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.message == message &&
        other.time == time &&
        other.isMe == isMe;
  }

  @override
  int get hashCode {
    return name.hashCode ^ message.hashCode ^ time.hashCode ^ isMe.hashCode;
  }
}
