class WalletDepositRequestModel {
  final double amount;

  WalletDepositRequestModel({
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}

