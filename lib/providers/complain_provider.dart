import 'package:flutter/cupertino.dart';
import 'package:hydrogen_complian/models/complain_model.dart';

import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EnumState { loading, error, success, unknown }

class ComplainProvider extends ChangeNotifier {
  List<ComplainModel> complains = [];
  EnumState state = EnumState.unknown;

  getComplainList() async {
    try {
      state = EnumState.loading;
      notifyListeners();

      final SharedPreferences pref = await SharedPreferences.getInstance();
      GeneralHttpRequest generalHttpRequest = GeneralHttpRequest();

      List response = await generalHttpRequest.getAllComplaintsForUsers(
        token: pref.getString('token'),
        api: '/getAlComplaintsForUser',
      );

      complains.clear();

      for (int i = 0; i <= response.length - 1; i++) {
        var data = ComplainModel.fromJson(response[i]);
        complains.add(data);
      }

      print(complains);

      state = EnumState.success;
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);

      state = EnumState.error;
      notifyListeners();
    }
  }

  // init() async {
  //   await getComplainList();
  // }
}
