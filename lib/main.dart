import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gdg_ha_chat/ui/chat_app.dart';

/// Точка входа в приложение
///
/// Будет асинхронная, т.к. нам нужно в ней асинхронно настроить Firestore.
Future<void> main() async {
  // Настроим Firestore так, чтоб в качестве времени оно возвращало [Timestamp]
  await Firestore.instance.settings(timestampsInSnapshotsEnabled: true);

  /// Запустим приложение
  runApp(new ChatApp());
}
