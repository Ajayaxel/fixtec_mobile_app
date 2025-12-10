import 'package:fixteck/const/reward_conatiner.dart';
import 'package:fixteck/ui/wallet/payment_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/data/repositories/wallet_repository.dart';
import 'package:fixteck/data/models/wallet_deposit_request_model.dart';
import 'package:fixteck/bloc/wallet_bloc.dart';
import 'package:fixteck/bloc/wallet_event.dart';
import 'package:fixteck/bloc/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixteck/core/utils/loading_helper.dart';
import 'package:fixteck/ui/widgets/global_loading_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch wallet balance when screen loads
    context.read<WalletBloc>().add(const FetchWalletBalance());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletLoading) {
          LoadingHelper.show(
            context: context,
            message: 'Loading wallet balance...',
          );
        } else {
          LoadingHelper.hide();
        }

        if (state is WalletError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: const SizedBox.shrink(),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Help & Support',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildWalletBalanceSection(state),
              const SizedBox(height: 24),
              RewardConatiner(),
              const SizedBox(height: 24),
              _buildTransactionsSection(),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildWalletBalanceSection(WalletState state) {
    String balance = '0.00';
    String availableBalance = '0.00';
    String currency = 'AED';

    if (state is WalletLoaded) {
      balance = state.response.data.balance;
      availableBalance = state.response.data.availableBalance.toStringAsFixed(2);
      currency = state.response.data.currency;
      print('🔵 [WalletScreen] Displaying balance: $balance $currency');
      print('🔵 [WalletScreen] Available balance: $availableBalance $currency');
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xffECEBF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/home/wallet.png',
                height: 60,
                width: 60,
                fit: BoxFit.contain,
              ),
              Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$currency $balance',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppThemes.bgBtnColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cash',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01031F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$currency $availableBalance',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01031F),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Bonus',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01031F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$currency 0.00',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01031F),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Have a coupon code?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppThemes.bgBtnColor,
            ),
          ),
          const SizedBox(height: 16),
          FixtecBtn(
            onPressed: () {
              _showAddMoneyBottomSheet(context);
            },
            bgColor: AppThemes.bgBtnColor,
            textColor: AppThemes.textBtnColor,
            child: const Text('Add money'),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Container(
      height: 130,
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xffE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff9293A8)),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Text(
                  'All Transactions',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff9293A8)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Addition',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff9293A8)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Deduction',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "No transactions in this category",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMoneyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _AddMoneyBottomSheet();
      },
    );
  }
}

class _AddMoneyBottomSheet extends StatefulWidget {
  @override
  State<_AddMoneyBottomSheet> createState() => _AddMoneyBottomSheetState();
}

class _AddMoneyBottomSheetState extends State<_AddMoneyBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  final WalletRepository _walletRepository = WalletRepository();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handleProceedToPay() async {
    final amountText = _amountController.text.trim();
    
    if (amountText.isEmpty) {
      print('🔴 [WalletScreen] Amount is empty');
      _showErrorMessage('Please enter an amount');
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      print('🔴 [WalletScreen] Invalid amount: $amountText');
      _showErrorMessage('Please enter a valid amount');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('🔵 [WalletScreen] Initiating wallet deposit for amount: $amount');
      
      final request = WalletDepositRequestModel(amount: amount);
      final response = await _walletRepository.deposit(request);

      print('✅ [WalletScreen] Deposit API call successful');
      print('✅ [WalletScreen] Payment URL: ${response.data.paymentUrl}');
      print('✅ [WalletScreen] Payment ID: ${response.data.paymentId}');
      print('✅ [WalletScreen] Status: ${response.data.status}');

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate to payment webview
        Navigator.of(context).pop(); // Close bottom sheet
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentWebViewScreen(
              paymentUrl: response.data.paymentUrl,
              amount: amount.toStringAsFixed(2),
            ),
          ),
        );
      }
    } catch (e) {
      print('🔴 [WalletScreen] Deposit failed: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorMessage(e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Draggable handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title
            const Text(
              'Add money to Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            // Input field
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount: Example 500 AED',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppThemes.bgBtnColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Proceed to pay button
            _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: GlobalLoadingIndicator(),
                    ),
                  )
                : FixtecBtn(
                    onPressed: _handleProceedToPay,
                    bgColor: AppThemes.bgBtnColor,
                    textColor: AppThemes.textBtnColor,
                    child: const Text('Proceed to pay'),
                  ),
          ],
        ),
      ),
    );
  }
}
