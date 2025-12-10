class WalletBalanceResponseModel {
  final bool success;
  final WalletBalanceData data;
  final String message;

  WalletBalanceResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory WalletBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceResponseModel(
      success: json['success'] as bool,
      data: WalletBalanceData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }
}

class WalletBalanceData {
  final int walletId;
  final String balance;
  final double availableBalance;
  final String reservedBalance;
  final String currency;
  final String status;
  final String? lastTransactionAt;

  WalletBalanceData({
    required this.walletId,
    required this.balance,
    required this.availableBalance,
    required this.reservedBalance,
    required this.currency,
    required this.status,
    this.lastTransactionAt,
  });

  factory WalletBalanceData.fromJson(Map<String, dynamic> json) {
    return WalletBalanceData(
      walletId: json['wallet_id'] as int,
      balance: json['balance'] as String,
      availableBalance: (json['available_balance'] as num).toDouble(),
      reservedBalance: json['reserved_balance'] as String,
      currency: json['currency'] as String,
      status: json['status'] as String,
      lastTransactionAt: json['last_transaction_at'] as String?,
    );
  }
}

