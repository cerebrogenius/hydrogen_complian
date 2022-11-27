import 'package:flutter/cupertino.dart';
import 'package:hydrogen_complian/models/complain_model.dart';

import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EnumState { loading, error, success, unknown }

class ComplainProvider extends ChangeNotifier {
  List<ComplainModel> complains = [];
  EnumState state = EnumState.unknown;
  String errorText = '';

  getComplainList() async {
    try {
      state = EnumState.loading;
      errorText = '';
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

      complains = complains.reversed.toList();
      print(complains);

      // throw 'Network Error happened, try again';

      state = EnumState.success;
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);

      errorText = e.toString();
      state = EnumState.error;
      notifyListeners();
    }
  }

  // init() async {
  //   await getComplainList();
  // }
}
