class CustomerModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String phone;
  final String address;
  final bool status;
  final String createdAt;
  final String updatedAt;
  final String formattedCreatedAt;

  CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.phone,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedCreatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phone: json['phone'] as String,
      address: json['address'] as String,
      status: json['status'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      formattedCreatedAt: json['formatted_created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'address': address,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'formatted_created_at': formattedCreatedAt,
    };
  }
}

