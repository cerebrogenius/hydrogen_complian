import 'package:flutter/widgets.dart';

class PasteProvider extends ChangeNotifier {
  bool paste = false;
  bool changePaste() {
    paste = !paste;
    return paste;
  }
}
