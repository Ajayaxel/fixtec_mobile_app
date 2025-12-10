import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../const/themes/app_themes.dart';
import '../../bloc/wallet_bloc.dart';
import '../../bloc/wallet_event.dart';
import '../../ui/widgets/global_loading_widget.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final String amount;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.amount,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    print('🔵 [PaymentWebView] Initializing with URL: ${widget.paymentUrl}');
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('🔵 [PaymentWebView] Page started loading: $url');
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            print('✅ [PaymentWebView] Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
            
            // Check for success/error indicators in URL
            _checkPaymentStatus(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('🔴 [PaymentWebView] Web resource error: ${error.description}');
            setState(() {
              _isLoading = false;
              _errorMessage = 'Failed to load payment page. Please try again.';
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            print('🔵 [PaymentWebView] Navigation request: ${request.url}');
            // Allow all navigation
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkPaymentStatus(String url) {
    print('🔵 [PaymentWebView] Checking payment status for URL: $url');
    
    // Check for common success/error patterns in URL
    if (url.contains('success') || url.contains('completed') || url.contains('approved')) {
      print('✅ [PaymentWebView] Payment appears successful');
      _showSuccessMessage();
    } else if (url.contains('error') || url.contains('failed') || url.contains('cancelled')) {
      print('🔴 [PaymentWebView] Payment appears failed');
      _showErrorMessage('Payment failed. Please try again.');
    }
  }

  void _showSuccessMessage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Refresh wallet balance after successful payment
        try {
          context.read<WalletBloc>().add(const FetchWalletBalance());
          print('✅ [PaymentWebView] Refreshing wallet balance after successful payment');
        } catch (e) {
          print('🔴 [PaymentWebView] Error refreshing wallet balance: $e');
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Payment Successful'),
              content: const Text('Your payment has been processed successfully. The amount has been added to your wallet.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Close webview
                    Navigator.of(context).pop(); // Close bottom sheet
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppThemes.bgBtnColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            print('🔵 [PaymentWebView] Back button pressed');
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          'Complete Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                        _controller.reload();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemes.bgBtnColor,
                      ),
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            WebViewWidget(controller: _controller),
          if (_isLoading && _errorMessage == null)
            const GlobalLoadingWidget(),
        ],
      ),
    );
  }
}

