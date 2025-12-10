import 'customer_model.dart';

class LoginResponseModel {
  final bool success;
  final String message;
  final LoginData data;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class LoginData {
  final CustomerModel customer;
  final String token;
  final String tokenType;

  LoginData({
    required this.customer,
    required this.token,
    required this.tokenType,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      customer: CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      token: json['token'] as String,
      tokenType: json['token_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer.toJson(),
      'token': token,
      'token_type': tokenType,
    };
  }
}

