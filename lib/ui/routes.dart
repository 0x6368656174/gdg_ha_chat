import 'package:flutter/material.dart';

import 'package:gdg_ha_chat/ui/screens/auth/auth.dart';
import 'package:gdg_ha_chat/ui/screens/chat/chat.dart';
import 'package:gdg_ha_chat/ui/screens/loading/loading.dart';

/// Маршруты приложения
final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new LoadingScreen(),
  '/chat': (BuildContext context) => new ChatScreen(),
  '/sign_in': (BuildContext context) => new AuthScreen(),
};
