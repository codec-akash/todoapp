import 'dart:async';
import 'package:todoapp/models/classes/user.dart';
import 'api.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname,
          String email, String password) =>
      apiProvider.registerUser(
          username, firstname, lastname, email, password);

  Future signinUser(String username, String password, String apiKey) =>
      apiProvider.signinUser(
          username, password, apiKey);

  Future getUserTasks(String apiKey) =>
      apiProvider.getUserTasks(apiKey); 
}

