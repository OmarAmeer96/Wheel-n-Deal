import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void sendMessage(
  CollectionReference<Object?> messages,
  String value,
  TextEditingController messageController,
  DateTime currentTime,
  BuildContext context,
) {
  messages
      .add({
        'message': value,
        'sentAt': currentTime,
      })
      .then(
        (value) => log(
          'message sent',
        ),
      )
      .catchError(
        (error) => log(
          'Failed to send message, the error: $error',
        ),
      );
  messageController.clear();
  FocusScope.of(context).unfocus();
}
