import 'package:untitled2/data/db.dart';
import 'package:untitled2/data/model.dart';


class UserController extends GetxController {
  var userList = <User>[].obs;

  final DBHelper dbHelper = DBHelper();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  /// FETCH USERS
  void fetchUsers() async {
    final data = await dbHelper.getUsers();
    userList.value = data;
  }

  /// ADD USER
  void addUser(String name, String email) async {
    final user = User(name: name, email: email);
    await dbHelper.insertUser(user);
    fetchUsers();
  }

  /// UPDATE USER
  void updateUser(User user) async {
    await dbHelper.updateUser(user);
    fetchUsers();
  }

  /// DELETE USER
  void deleteUser(int id) async {
    await dbHelper.deleteUser(id);
    fetchUsers();
  }
}
