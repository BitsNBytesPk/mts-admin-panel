import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';

class FilePickerFunctions {

  FilePickerFunctions._privateConstructor();
  static final FilePickerFunctions _instance = FilePickerFunctions._privateConstructor();

  factory FilePickerFunctions() {
    return _instance;
  }

  static void pickSingleImage({required Rx<Uint8List> imageToUpload}) async {
    final image = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        compressionQuality: 1,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    if(image != null) {
      imageToUpload.value = image.files.first.bytes!;
    }
  }

  static Future<FilePickerResult?> pickSingleVideo({int maxSize = 20}) async {
    final video = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      compressionQuality: 1,
      allowMultiple: false,
      withData: true,
      // withReadStream: true,
      allowedExtensions: ['mp4', 'webm']
    );

    if(video != null) {
      if(video.files.first.size > (maxSize * 1024 * 1024)) {
        showSnackBar(message: 'File exceeds size limit', success: false);
        return null;
      } else {
        return video;
      }
    } else {
      return null;
    }
  }

}