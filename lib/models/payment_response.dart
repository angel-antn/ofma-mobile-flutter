import 'package:ofma_app/models/bank_account_response.dart';
import 'package:ofma_app/models/exchange_rate_response.dart';

class PaymentResponse {
  BankAccountResponse? bankAccountResponse;
  ExchangeRateResponse? exchangeRateResponse;

  PaymentResponse({this.bankAccountResponse, this.exchangeRateResponse});
}
