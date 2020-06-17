import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/classes/task.dart';
import 'dart:convert';
import 'package:todoapp/models/classes/user.dart';

class ApiProvider {
  Client client = Client();
  //final _apiKey = 'your_api_key';

  Future signinUser(String username, String password, String apiKey) async {
    final response = await client.post("http://10.0.2.2:5000/api/signin",
        headers: {
          "Authorization" : apiKey
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    final Map result = json.decode(response.body);
    print(result['data'].toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result['data']["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<User> registerUser(String username, String firstname, String lastname,
      String email, String password) async {
    final response = await client.post("http://10.0.2.2:5000/api/register",
        // headers: {},
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        }));
    final Map result = json.decode(response.body);
    print(result['data'].toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result['data']["api_key"]);
      return User.fromJson(result['data']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Task>> getUserTasks(String apiKey) async {
    final response = await client.get("http://10.0.2.2:5000/api/tasks",
        headers: {
          "Authorization" : apiKey
        },
        );
    final Map result = json.decode(response.body);
    print(result['data'].toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      List<Task> tasks = [];
      for(Map json_ in result["data"]){
        print("\n\n\n" + json_.toString());
        try{
          tasks.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      for(Task task_ in tasks){
        print(task_.title);
      }
      return tasks;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_TOKEN', api_key);
  }
}
