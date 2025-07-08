import '../repositories/auth_repository_interface.dart';
import 'auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthRepositoryInterface authRepositoryInterface;

  AuthService(this.authRepositoryInterface);

  @override
  Future register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    return await authRepositoryInterface.register(
      name,
      email,
      password,
      confirmPassword,
    );
  }

  @override
  Future accessAndRefreshToken(String refreshToken) async {
    return await authRepositoryInterface.accessAndRefreshToken(refreshToken);
  }

  @override
  Future login(String email, String password) async {
    return await authRepositoryInterface.login(email, password);
  }

  @override
  Future changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async{
    return await authRepositoryInterface.changePassword(currentPassword, newPassword, confirmPassword);
  }

  @override
  Future forgetPassword(String? email) async {
    return await authRepositoryInterface.forgetPassword(email);
  }

  @override
  Future verifyCode(String otp, String email) async {
    return await authRepositoryInterface.verifyCode(otp, email);
  }

  @override
  Future resetPassword(String newPassword, String confirmNewPassword) async {
    return await authRepositoryInterface.resetPassword(newPassword, confirmNewPassword);
  }

  @override
  bool isLoggedIn() {
    return authRepositoryInterface.isLoggedIn();
  }

  @override
  Future logout() {
    return authRepositoryInterface.logout();
  }

  @override
  Future<bool?> saveUserToken(String token, String refreshToken) async {
    return await authRepositoryInterface.saveUserToken(token, refreshToken);
  }

  @override
  bool isFirstTimeInstall() {
    return authRepositoryInterface.isFirstTimeInstall();
  }

  @override
  void setFirstTimeInstall() {
    return authRepositoryInterface.setFirstTimeInstall();
  }

  @override
  bool clearSharedAddress() {
    // TODO: implement clearSharedAddress
    throw UnimplementedError();
  }

  @override
  Future<bool> clearUserCredentials() {
    // TODO: implement clearUserCredentials
    throw UnimplementedError();
  }

  @override
  String getUserToken() {
    // TODO: implement getUserToken
    throw UnimplementedError();
  }

  @override
  Future resendOtp(String email) {
    // TODO: implement resendOtp
    return authRepositoryInterface.forgetPassword(email);
  }

  @override
  Future sendOtp({required String phone}) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future updateAccessAndRefreshToken() {
    // TODO: implement updateAccessAndRefreshToken
    throw UnimplementedError();
  }

  @override
  Future updateToken() {
    // TODO: implement updateToken
    throw UnimplementedError();
  }
}
