import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {}

  void signIn() {}

  void website() {}

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'deokooyoo@gmail.com',
    );
    _launch(emailLaunchUri as String);
  }

  Future<void> _launch(String url) async {
    if (!await launchUrl(url as Uri)) {
      throw 'could not launch $url';
    }
  }
}
