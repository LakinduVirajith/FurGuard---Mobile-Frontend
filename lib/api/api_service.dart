import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "192.168.56.1:8080/user/authenticate";

    final response = await http.post(url as Uri, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}