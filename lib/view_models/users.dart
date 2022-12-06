import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_be/models/users.dart';
import 'package:flutter_be/services/web_api.dart';

class UsersViewModel extends Model {
  Future<List<User>> usersList = RequestApi().getUsers();
}

class UserViewModel extends Model {
  late Future<User> singleUser;
  UserViewModel(String username) {
    singleUser = RequestApi().getUser(username);
  }
}

class SearchViewModel extends Model {
  late Future<List<User>> usersList;
  SearchViewModel(String param) {
    usersList = RequestApi().searchUser(param);
  }
}

class DeleteUserModel extends Model {
  late Future<bool> singleUser;
  DeleteUserModel(String username) {
    singleUser = RequestApi().deleteUser(username);
  }
}

class UpdateUserModel extends Model {
  late Future<String> singleUser;
  UpdateUserModel(String username, User oldData, Map newData) {
    var dataBody = <String, dynamic>{};
    newData.forEach((key, value) {
      if (value != 'null') {
        if (value.toString() != oldData.toJson()[key].toString()) {
          dataBody.putIfAbsent(key, () => value);
        }
      }
    });
    //print(dataBody);
    singleUser = RequestApi().updateUser(username, dataBody);
  }
}

class CreateUserModel extends Model {
  late Future<String> singleUser;
  CreateUserModel(Map newData) {
    singleUser = RequestApi().createUser(newData);
  }
}
