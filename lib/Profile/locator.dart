import 'userController.dart';
import 'package:get_it/get_it.dart';
import '../services/auth.dart';


final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<Auth>(Auth());
  locator.registerSingleton<UserController>(UserController());
}