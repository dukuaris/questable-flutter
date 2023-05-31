import 'package:get/get.dart';
import 'package:questable_quiz_flutter/controllers/theme_controller.dart';

import '../controllers/auth_controller.dart';
import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ThemeController(),
    );
    Get.put(
      AuthController(),
      permanent: true,
    );
    Get.lazyPut(() => FirebaseStorageService());
  }
}
