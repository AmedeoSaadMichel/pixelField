class AuthRepository {
  Future<void> login() async {
    //attempting login
    await Future.delayed(Duration(seconds: 3));
    print('logged in');
    throw Exception('failed log in');
  }
}