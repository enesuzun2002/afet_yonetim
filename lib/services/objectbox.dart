import 'package:afet_yonetim/model/user.dart';
import 'package:afet_yonetim/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService {
  late final Store store;
  late final Box<UserModel> userBox;

  Future<void> init() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    store = Store(getObjectBoxModel(), directory: "$path/objectbox");
    userBox = store.box<UserModel>();
  }

  Future<UserModel?> getUser() async {
    return userBox.get(1);
  }

  Future<void> addUser(UserModel user) async {
    userBox.put(user);
  }

  Future<void> clearUsers() async {
    userBox.removeAll();
  }
}
