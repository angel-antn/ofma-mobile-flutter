import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/data/remote/ofma/user_request.dart';
import 'package:ofma_app/models/orders_response.dart';
import 'package:ofma_app/models/payment_params.dart';

class OrderRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/order';

  Future<OrdersResponse?> getOrdersByUser({required int page}) async {
    final user = Preferences.user;
    final url = Uri.http(_baseUrl, '$_path/user/${user?.id ?? ''}',
        {'page': page.toString(), 'pageSize': '4'});

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${Preferences.token}',
      },
    );

    if (response.statusCode == 200) {
      return OrdersResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Order?> createOrder(
      {String? transferBankAccountId,
      String? zelleBankAccountId,
      String? mobilePayBankAccountId,
      String? exchangeRateId,
      required String reference,
      required DateTime paidAt,
      required PaymentParams paymentParams}) async {
    final url = Uri.http(_baseUrl, _path);

    String status = 'pendiente';

    if (mobilePayBankAccountId == null &&
        zelleBankAccountId == null &&
        transferBankAccountId == null) {
      status = 'verificado';
    }

    final body = {
      'amount': paymentParams.amount.toString(),
      'type': paymentParams.type,
      'paidAt': '${paidAt.year}-${paidAt.month}-${paidAt.day}',
      'status': status,
      'userId': Preferences.user?.id ?? '',
      'reference': reference
    };

    if (transferBankAccountId != null) {
      body['transferBankAccountId'] = transferBankAccountId;
    }
    if (zelleBankAccountId != null) {
      body['zelleBankAccountId'] = zelleBankAccountId;
    }
    if (mobilePayBankAccountId != null) {
      body['mobilePayBankAccountId'] = mobilePayBankAccountId;
    }
    if (exchangeRateId != null) {
      body['exchangeRateId'] = exchangeRateId;
    }

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Authorization': 'Bearer ${Preferences.token}',
      },
    );

    //TODO: only for presentations
    await Future.delayed(const Duration(milliseconds: 2000));

    if (response.statusCode == 201) {
      final userRequest = UserRequest();
      userRequest.me();
      final userResponse = await userRequest.me();
      if (userResponse != null) {
        Preferences.user = userResponse.user;
        Preferences.token = userResponse.token;
      }
      return Order.fromJson(response.body);
    } else {
      Fluttertoast.showToast(
          msg: 'No se pudo registrar el pago',
          backgroundColor: Colors.grey,
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }
}
