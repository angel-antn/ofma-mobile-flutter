class PaymentParams {
  final String type;
  final double amount;
  final String? concertId;

  PaymentParams({required this.type, required this.amount, this.concertId});
}
