import 'package:data/data.dart';

final class RemoteAdminDataSourceImpl implements RemoteAdminDataSource {
  final FirebaseFirestore firebaseFirestore;

  RemoteAdminDataSourceImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<List<int>> getUsersPerDay() async {
    try {
      List<int> userCounts = <int>[];
      QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection(FirebaseEnum.users.name)
          .orderBy(FirebaseEnum.registrationDate.name, descending: true)
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;
      DateTime currentDate = DateTime.now();

      for (int i = 0; i < 7; i++) {
        DateTime date = currentDate.subtract(Duration(days: i));
        int count = 0;

        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in documents) {
          DateTime registrationDate =
              document[FirebaseEnum.registrationDate.name].toDate();
          if (registrationDate.year == date.year &&
              registrationDate.month == date.month &&
              registrationDate.day == date.day) {
            count++;
          }
        }
        userCounts.add(count);
      }
      return userCounts.reversed.toList();
    } on FirebaseException catch (e) {
      throw AppFireBaseException(e.toString());
    }
  }

  @override
  Future<List<UserModel>> getUsersByRegistrationDate() async {
    final List<UserModel> userList = <UserModel>[];

    try {
      final QuerySnapshot<Map<String, dynamic>> firebaseFireStore =
          await FirebaseFirestore.instance
              .collection(FirebaseEnum.users.name)
              .get();

      for (final QueryDocumentSnapshot<Map<String, dynamic>> element
          in firebaseFireStore.docs) {
        userList.add(UserModel.fromJson(element.data()));
      }
    } on FirebaseException catch (e) {
      throw AppFireBaseException(e.toString());
    }
    return userList;
  }

  @override
  Future<void> addProduct(ProductModel productModel) async {
    await firebaseFirestore
        .collection(FirebaseEnum.coffee.name)
        .add(productModel.toJson());
  }
}
