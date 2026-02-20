import 'package:get/get.dart';
import 'db_helper.dart';
import 'user_model.dart';

class UserController extends GetxController {

  final DBHelper dbHelper = DBHelper();

  var userList = <User>[].obs;

  var isLoading = false.obs;

  var hasMore = true.obs;

  int limit = 10;
  int offset = 0;

  int? startIdFilter;
  int? endIdFilter;

  String? startDateFilter;
  String? endDateFilter;

  @override
  void onInit() {

    fetchUsers();

    super.onInit();
  }

  /// FETCH USERS
  void fetchUsers({bool loadMore = false}) async {

    if (isLoading.value) return;

    isLoading.value = true;

    if (!loadMore) {

      offset = 0;
      userList.clear();
      hasMore.value = true;

    }

    final data =
    await dbHelper.getUsersPaginated(

      limit: limit,
      offset: offset,
      startId: startIdFilter,
      endId: endIdFilter,
      startDate: startDateFilter,
      endDate: endDateFilter,

    );

    if (data.length < limit) {

      hasMore.value = false;

    }

    offset += data.length;

    userList.addAll(data);

    isLoading.value = false;
  }

  /// LOAD MORE
  void loadMore() {

    if (hasMore.value) {

      fetchUsers(loadMore: true);

    }
  }

  /// ADD USER
  void addUser(String name, String email) async {

    String date =
    DateTime.now().toString().substring(0, 10);

    await dbHelper.insertUser(
      User(
        name: name,
        email: email,
        date: date,
      ),
    );

    fetchUsers();
  }

  /// UPDATE
  void updateUser(User user) async {

    await dbHelper.updateUser(user);

    fetchUsers();
  }

  /// DELETE
  void deleteUser(int id) async {

    await dbHelper.deleteUser(id);

    fetchUsers();
  }

  /// FILTER ID
  void applyIdFilter(int start, int end) {

    startIdFilter = start;
    endIdFilter = end;

    fetchUsers();
  }

  /// FILTER DATE
  void applyDateFilter(String start, String end) {

    startDateFilter = start;
    endDateFilter = end;

    fetchUsers();
  }

  /// CLEAR FILTER
  void clearFilter() {

    startIdFilter = null;
    endIdFilter = null;
    startDateFilter = null;
    endDateFilter = null;

    fetchUsers();
  }

} 