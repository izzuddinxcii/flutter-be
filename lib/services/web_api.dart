import 'package:requests/requests.dart';
import 'package:flutter_be/models/users.dart';

class RequestApi {
  Future<List<User>> getUsers() async {
    var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/users';
    var response = await Requests.get(url);
    if (response.statusCode == 200) {
      return usersFromJson(response.body);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<User> getUser(String username) async {
    var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/user/$username';
    var response = await Requests.get(url);
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<User>> searchUser(String searchParam) async {
    var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/users/$searchParam';
    var response = await Requests.get(url);
    if (response.statusCode == 200) {
      return usersFromJson(response.body);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<bool> deleteUser(String username) async {
    var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/user/$username';
    var response = await Requests.delete(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> updateUser(String username, Map dataBody) async {
    if (dataBody.isNotEmpty) {
      var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/user/$username';
      var response = await Requests.put(url, json: dataBody);
      if (response.statusCode == 200) {
        return 'Update data Success\n\nData Updated\n${(dataBody.values.join('\n'))}';
      } else {
        return 'Update Fail';
      }
    } else {
      return 'No New Data';
    }
  }

  Future<String> createUser(Map dataBody) async {
    var url = 'http://etiqa.ap-southeast-1.elasticbeanstalk.com/user';
    var response = await Requests.post(url, json: dataBody);
    if (response.statusCode == 200) {
      return 'User Created';
    } else {
      return 'Update Fail';
    }
  }
}
