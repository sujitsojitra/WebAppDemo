import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_demowebapp/Http/request.dart';
import 'package:flutter_demowebapp/Http/url.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  void apiLogin() async {

    Get.dialog(Center(child: CircularProgressIndicator(semanticsLabel: "Loading",)), barrierDismissible: false);
    Request request = Request(url: urlLogin, body: {
      'email': emailTextController.text,
      'password': passwordTextController.text
    });
    request.post().then((value) {

    }).catchError((onError) {});
  }

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.onClose();
  }
}