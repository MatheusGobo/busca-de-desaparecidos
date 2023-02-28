
import 'package:file_picker/file_picker.dart';

class PickerFile {
  Future<PlatformFile?> selectFile() async {
    PlatformFile? _file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      _file = result.files.first;
    } else {
      _file = null;
    }
    return _file;
  }
}