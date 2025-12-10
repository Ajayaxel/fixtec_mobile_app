import 'customer_model.dart';

class ProfileResponseModel {
  final bool success;
  final ProfileData data;

  ProfileResponseModel({
    required this.success,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'] as bool,
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class ProfileData {
  final CustomerModel customer;

  ProfileData({
    required this.customer,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      customer: CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer.toJson(),
    };
  }
}

