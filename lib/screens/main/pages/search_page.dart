import 'package:flutter/material.dart';
import 'package:ofma_app/components/stripe/stripe_payment_button.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Buscar')),
      body: const Column(
        children: [
          StripePaymentButton(
            amount: 43.3333,
            text: 'pagar',
            width: 300,
          )
        ],
      ),
    );
  }
}
