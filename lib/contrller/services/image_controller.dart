import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  RxString imagePath = "".obs;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      imagePath.value = image.path;
    }
  }
}
