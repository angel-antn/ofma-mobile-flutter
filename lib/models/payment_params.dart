class PaymentParams {
  final String type;
  final double amount;
  final String? concertId;
  final int? ticketQty;

  PaymentParams({
    required this.type,
    required this.amount,
    this.concertId,
    this.ticketQty,
  });
}
