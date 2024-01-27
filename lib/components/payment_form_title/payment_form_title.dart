import 'package:flutter/material.dart';
import 'package:ofma_app/models/exchange_rate_response.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PaymentFormTitle extends StatelessWidget {
  const PaymentFormTitle({
    super.key,
    required this.title,
    this.exchangeRate,
    required this.amount,
  });

  final String title;
  final ExchangeRateResponse? exchangeRate;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Text(
            '${(amount * (exchangeRate?.rate ?? 1)).toStringAsFixed(2)} ${exchangeRate == null ? 'USD' : 'VES'}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
