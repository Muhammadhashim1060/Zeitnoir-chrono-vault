import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class FlutterwaveService {
  static Future<void> startSubscription({
    required BuildContext context,
    required String plan,
    required double amountUsd,
  }) async {
    // NOTE: Replace with your publicKey/secretKey and customer details.
    final style = FlutterwaveStyle(
      appBarText: "Depth.EI Subscription",
      buttonColor: const Color(0xFF00FFB7),
      appBarColor: const Color(0xFF121212),
      dialogCancelTextStyle: const TextStyle(color: Colors.red),
      dialogContinueTextStyle: const TextStyle(color: Colors.blue),
      mainTextStyle: const TextStyle(color: Colors.black),
      buttonTextStyle: const TextStyle(color: Colors.black),
      appBarIcon: const Icon(Icons.arrow_back, color: Colors.white),
      buttonText: "Pay",
      appBarTitleTextStyle: const TextStyle(color: Colors.white),
    );

    final customer = Customer(name: "Depth.EI User", phoneNumber: "", email: "");

    final flutterwave = Flutterwave(
      context: context,
      style: style,
      publicKey: "FLWPUBK_TEST-REPLACE",
      currency: "USD",
      redirectUrl: "https://webhook.site/redirect",
      txRef: "depth_sub_${DateTime.now().millisecondsSinceEpoch}",
      amount: amountUsd.toStringAsFixed(2),
      customer: customer,
      paymentOptions: "card, account, barter, banktransfer, ussd",
      customization: Customization(title: "Depth.EI ${plan.toUpperCase()}"),
      isTestMode: true,
    );

    final response = await flutterwave.charge();
    if (response != null && response.status?.toLowerCase() == 'successful') {
      // TODO: Call backend to verify and record subscription; webhook will also credit wallet
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment successful')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment cancelled or failed')));
    }
  }
}
