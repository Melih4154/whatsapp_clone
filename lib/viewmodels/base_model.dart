import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';

abstract class BaseModel with ChangeNotifier {
  NavigatorService navigatorService = getIt<NavigatorService>();

  bool _busy = false;

  bool get busy => _busy;

  set busy(bool state) {
    _busy = state;

    notifyListeners();
  }
}
