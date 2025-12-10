class WalletDepositResponseModel {
  final bool success;
  final WalletDepositData data;
  final String message;

  WalletDepositResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory WalletDepositResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletDepositResponseModel(
      success: json['success'] as bool,
      data: WalletDepositData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }
}

class WalletDepositData {
  final String paymentId;
  final String intentionId;
  final String paymentUrl;
  final List<PaymentMethod> paymentMethods;
  final double amount;
  final String currency;
  final String status;
  final String specialReference;

  WalletDepositData({
    required this.paymentId,
    required this.intentionId,
    required this.paymentUrl,
    required this.paymentMethods,
    required this.amount,
    required this.currency,
    required this.status,
    required this.specialReference,
  });

  factory WalletDepositData.fromJson(Map<String, dynamic> json) {
    return WalletDepositData(
      paymentId: json['payment_id'] as String,
      intentionId: json['intention_id'] as String,
      paymentUrl: json['payment_url'] as String,
      paymentMethods: (json['payment_methods'] as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      specialReference: json['special_reference'] as String,
    );
  }
}

class PaymentMethod {
  final int integrationId;
  final String? alias;
  final String name;
  final String methodType;
  final String currency;
  final bool live;
  final bool useCvcWithMoto;

  PaymentMethod({
    required this.integrationId,
    this.alias,
    required this.name,
    required this.methodType,
    required this.currency,
    required this.live,
    required this.useCvcWithMoto,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      integrationId: json['integration_id'] as int,
      alias: json['alias'] as String?,
      name: json['name'] as String,
      methodType: json['method_type'] as String,
      currency: json['currency'] as String,
      live: json['live'] as bool,
      useCvcWithMoto: json['use_cvc_with_moto'] as bool,
    );
  }
}

