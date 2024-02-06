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
    double finalAmount = (amount * (exchangeRate?.rate ?? 1));
    if (exchangeRate == null) {
      finalAmount *= 1.03;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            if (exchangeRate == null)
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: const Text(
                  'IGTF',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              child: Text(
                '${finalAmount.toStringAsFixed(2)} ${exchangeRate == null ? 'USD' : 'VES'}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        )
      ],
    );
  }
}
