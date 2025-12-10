import 'customer_model.dart';

class RegisterResponseModel {
  final bool success;
  final String message;
  final RegisterData data;

  RegisterResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: RegisterData.fromJson(json['data'] as Map<String, dynamic>),
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

class RegisterData {
  final CustomerModel customer;
  final String token;
  final String tokenType;

  RegisterData({
    required this.customer,
    required this.token,
    required this.tokenType,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
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

