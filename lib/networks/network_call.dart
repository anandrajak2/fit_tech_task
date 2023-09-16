import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task_project_16/models/dog_image_model.dart';
import 'package:task_project_16/models/userListResponse.dart';
import 'package:task_project_16/networks/endPoints.dart';

import 'exceptions.dart';

class NetworkCall {
  Future<Either<NetworkExceptionModule, UsersListModel>> getUserList() async {
    var response = await http.get(Uri.parse(USER_LIST_API));
    if (response.statusCode == 200) {
      return right(UsersListModel.fromJson(jsonDecode(response.body)));
    } else {
      return left(NetworkExceptionModule(
          code: response.statusCode.toString(),
          message: response.reasonPhrase));
    }
  }

  Future<Either<NetworkExceptionModule, DogImageModel>> getDogImage() async {
    var response = await http.get(Uri.parse(DOG_IMAGE_API));
    if (response.statusCode == 200) {
      return right(DogImageModel.fromJson(jsonDecode(response.body)));
    } else {
      return left(NetworkExceptionModule(
          code: response.statusCode.toString(),
          message: response.reasonPhrase));
    }
  }
}
