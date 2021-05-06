import 'package:flutter_demowebapp/Http/request.dart';
import 'package:flutter_demowebapp/Http/url.dart';
import 'package:flutter_demowebapp/model/user_list_model.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  var isLoading=true.obs;
  var isGrid=true.obs;
  var userListData = List<User>.empty().obs;
  @override
  void onInit() {
    _apiGetUserList();
    super.onInit();
  }

  void _apiGetUserList() async {
    Request request = Request(url: urlUserList, body: null);
    request.get().then((value) {
      userListData = userFromJson(value.body).obs;
      isLoading(false);
    }).catchError((onError) {
      print(onError);
      isLoading(false);
    });
  }

  void deleteItem(int index) {
    userListData.removeAt(index);
  }
}