import 'package:data/data.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient;
  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? StringConstants.error,
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: StringConstants.code_500,
      );
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = result.user;
      if (user == null) {
        throw const ServerException(
          message: StringConstants.tryLater,
          statusCode: StringConstants.error,
        );
      }

      DocumentSnapshot<Map<String, dynamic>> userData =
          await _getUserData(user.uid);
      if (userData.exists) {
        return UserModel.fromJson(userData.data()!);
      }
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return UserModel.fromJson(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? StringConstants.error,
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: StringConstants.code_500,
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(fullName);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? StringConstants.error,
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: StringConstants.code_500,
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient
        .collection(
          FirebaseEnum.users.name,
        )
        .doc(uid)
        .get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient
        .collection(
          FirebaseEnum.users.name,
        )
        .doc(user.uid)
        .set(
          UserModel(
            emailIsVerified: user.emailVerified,
            username: user.displayName ?? '',
            bio: '',
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? '',
            image: user.photoURL ?? '',
          ).toMap(),
        );
  }

  @override
  Future<void> logOut() async {
    try {
      await _authClient.signOut();
    } catch (e) {
      throw ServerFailure(
        message: e.toString(),
        statusCode: e,
      );
    }
  }
}
