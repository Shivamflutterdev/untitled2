import 'package:get/get.dart';
import 'api_service.dart';
import 'user_model.dart';

class UserController extends GetxController {

  final ApiService api = ApiService();

  var userList = <User>[].obs;

  var isLoading = false.obs;
  var isPaginationLoading = false.obs;
  var hasMore = true.obs;

  int page = 1;

  /// FETCH USERS
  Future<void> fetchUsers({bool loadMore = false}) async {

    if (loadMore) {

      if (isPaginationLoading.value) return;

      isPaginationLoading.value = true;

    } else {

      isLoading.value = true;
      page = 1;
      userList.clear();
      hasMore.value = true;

    }

    final data = await api.fetchUsers(page);

    if (data.isEmpty) {

      hasMore.value = false;

    } else {

      userList.addAll(data);
      page++;

    }

    isLoading.value = false;
    isPaginationLoading.value = false;

  }

  /// ADD USER
  Future<void> addUser(String name, String email) async {

    await api.addUser(
      User(id: 0, name: name, email: email),
    );

    fetchUsers();

  }

  /// UPDATE USER
  Future<void> updateUser(User updatedUser) async {

    await api.updateUser(updatedUser);

    int index = userList.indexWhere(
            (e) => e.id == updatedUser.id);

    if (index != -1) {

      userList[index] = updatedUser;
      userList.refresh();

    }

  }

  /// DELETE USER
  Future<void> deleteUser(int id) async {

    await api.deleteUser(id);

    userList.removeWhere(
            (e) => e.id == id);

  }

}