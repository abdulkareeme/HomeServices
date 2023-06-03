import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  Future<List?> getUserOldData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List oldData = [];
    oldData.add(pref.get('first_name'));
    oldData.add(pref.get('last_name'));
    oldData.add(pref.get('bio'));
    oldData.add(pref.get('photo'));
    oldData.add(pref.get('birth_date'));
    oldData.add(pref.get('area'));
    return oldData;
  }

  static Future imagePicker(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if(file != null ){
      return await file.readAsBytes();
    } else {
      print("no such image");
    }
  }

}