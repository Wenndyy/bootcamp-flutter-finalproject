import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/values/urls.dart';
import '../model/register_user_request.dart';
import '../model/user_response.dart';

import '../services/dio_client.dart';

abstract class AuthRepository {
  Future<UserData?> getUserByEmail({required String email});

  Future<bool> registerUser({required UserBody userBody});
  Future<UserData?> getCurrentUserData();
  Future<bool> updateUser({required UserBody updatedUser});
}

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl(this.dioClient);

  @override
  Future<UserData?> getUserByEmail({required String email}) async {
    try {
      final result = await dioClient.get(
        Urls.users,
        queryParameters: {"email": email},
      );

      UserResponse res = UserResponse.fromJson(result);
      if ((res.message ?? '').contains('user tidak di temukan')) {
        return null;
      }
      return res.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getUserByEmail: $e, $stackTrace');
      }
      return null;
    }
  }

  @override
  Future<bool> registerUser({required UserBody userBody}) async {
    try {
      await dioClient.post(Urls.userRegister, body: userBody.toMap());
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err registerUser: $e, $stackTrace');
      }
      return false;
    }
  }

  @override
  Future<UserData?> getCurrentUserData() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      return await getUserByEmail(email: userEmail);
    }
    return null;
  }

  @override
  Future<bool> updateUser({required UserBody updatedUser}) async {
    try {
      await dioClient.post(
        Urls.userUpdate,
        body: updatedUser.toMap(),
      );
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err updateUser: $e, $stackTrace');
      }
      return false;
    }
  }
}
