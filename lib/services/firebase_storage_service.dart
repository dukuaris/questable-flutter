import 'package:get/get.dart';
import '../firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }

    try {
      var urlRef = firebaseStorage
          .child("question_group_images")
          .child('${imgName.toLowerCase()}.png');
      var url = await urlRef.getDownloadURL();
      return url;
    } catch (e) {
      print("Here comes the error of " + e.toString());
      return null;
    }
  }
}
