import 'locator.dart';
import '../models/user.dart';
import '../services/auth.dart';

class UserController {
  User _currentUser;
  Auth _authRepo = locator.get<Auth>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<User> initUser() async {
    _currentUser = (await _authRepo.getUser()) as User;
    return _currentUser;
  }

  User get currentUser => _currentUser;
}