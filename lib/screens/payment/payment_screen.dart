import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/data/remote/ofma/bank_accounts_request.dart';
import 'package:ofma_app/data/remote/ofma/exchange_rate_request.dart';
import 'package:ofma_app/models/bank_account_response.dart';
import 'package:ofma_app/models/exchange_rate_response.dart';
import 'package:ofma_app/models/payment_params.dart';
import 'package:ofma_app/models/payment_response.dart';
import 'package:ofma_app/screens/payment/forms/mobile_pay_form.dart';
import 'package:ofma_app/screens/payment/forms/stripe_form.dart';
import 'package:ofma_app/screens/payment/forms/transfer_form.dart';
import 'package:ofma_app/screens/payment/forms/zelle_form.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentParams});

  final PaymentParams paymentParams;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int methodSelectorIndex = 0;

  @override
  Widget build(BuildContext context) {
    setMethodSelectorIndex(int index) {
      setState(() {
        methodSelectorIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalle de pago'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const _PaymentHeader(),
            _PaymentBody(
                methodSelectorIndex: methodSelectorIndex,
                paymentParams: widget.paymentParams),
            _PayMethodSelector(
              methodSelectorIndex: methodSelectorIndex,
              setMethodSelector: setMethodSelectorIndex,
            )
          ],
        ),
      ),
    );
  }
}

class _PaymentHeader extends StatelessWidget {
  const _PaymentHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.maxFinite,
      child: Image.asset(
        'assets/backgrounds/payment_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PayMethodSelector extends StatelessWidget {
  const _PayMethodSelector({
    required this.setMethodSelector,
    required this.methodSelectorIndex,
  });

  final Function setMethodSelector;
  final int methodSelectorIndex;

  final int methodsQty = 4;

  @override
  Widget build(BuildContext context) {
    List<Widget> methodsList = List.generate(methodsQty, (index) {
      return _PayMethodSelectorCard(
        index: index,
        methodsQty: methodsQty,
        methodSelectorIndex: methodSelectorIndex,
        setMethodSelector: setMethodSelector,
      );
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: methodsList,
        ),
      ),
    );
  }
}

class _PayMethodSelectorCard extends StatefulWidget {
  const _PayMethodSelectorCard({
    required this.methodsQty,
    required this.methodSelectorIndex,
    required this.index,
    required this.setMethodSelector,
  });

  final int methodsQty;
  final int methodSelectorIndex;
  final int index;
  final Function setMethodSelector;

  @override
  State<_PayMethodSelectorCard> createState() => _PayMethodSelectorCardState();
}

class _PayMethodSelectorCardState extends State<_PayMethodSelectorCard> {
  bool ongoingAnimation = false;

  IconData getCardIcon(int index) {
    switch (index) {
      case 0:
        return CommunityMaterialIcons.bank;
      case 1:
        return CommunityMaterialIcons.cellphone_text;
      case 2:
        return CommunityMaterialIcons.currency_usd;
      case 3:
        return CommunityMaterialIcons.credit_card_check_outline;
      default:
        return Icons.abc;
    }
  }

  String getCardText(int index) {
    switch (index) {
      case 0:
        return 'Transferencia';
      case 1:
        return 'Pago móvil';
      case 2:
        return 'Zelle';
      case 3:
        return 'Tarjeta';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        if (widget.index != widget.methodSelectorIndex) {
          setState(() {
            ongoingAnimation = true;
          });
          widget.setMethodSelector(widget.index);
        }
      },
      child: AnimatedOpacity(
        opacity: widget.index != widget.methodSelectorIndex ? 0.8 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          onEnd: () {
            setState(() {
              ongoingAnimation = false;
            });
          },
          margin: EdgeInsets.only(
              left: widget.index == 0 ? 0 : 10,
              right: widget.index == widget.methodsQty - 1 ? 0 : 10),
          duration: const Duration(milliseconds: 120),
          width: widget.index == widget.methodSelectorIndex ? 110 : 80,
          height: widget.index == widget.methodSelectorIndex ? 110 : 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, offset: Offset(5, 5), blurRadius: 10)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                child: Icon(
                  getCardIcon(widget.index),
                  size: widget.index == widget.methodSelectorIndex ? 50 : 35,
                  color: AppColors.secondaryColor,
                ),
              ),
              if (widget.index == widget.methodSelectorIndex)
                AnimatedOpacity(
                  opacity: ongoingAnimation ? 0.2 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(fontSize: !ongoingAnimation ? 14 : 12),
                    duration: const Duration(milliseconds: 120),
                    child: Text(
                      getCardText(widget.index),
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentBody extends StatefulWidget {
  const _PaymentBody({
    required this.methodSelectorIndex,
    required this.paymentParams,
  });

  final int methodSelectorIndex;
  final PaymentParams paymentParams;

  @override
  State<_PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<_PaymentBody> {
  late Future<PaymentResponse> paymentFutureRequest;

  Future<PaymentResponse> _initPayment(BankAccountRequest bankAccountRequest,
      ExchangeRateRequest exchangeRateRequest) async {
    BankAccountResponse? bankAccountResponse =
        await bankAccountRequest.getBankAccounts();
    ExchangeRateResponse? exchangeRateResponse =
        await exchangeRateRequest.getLatestExchangeRate();
    return PaymentResponse(
        bankAccountResponse: bankAccountResponse,
        exchangeRateResponse: exchangeRateResponse);
  }

  @override
  void initState() {
    super.initState();
    final bankAccountRequest = BankAccountRequest();
    final exchangeRateRequest = ExchangeRateRequest();
    paymentFutureRequest =
        _initPayment(bankAccountRequest, exchangeRateRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 160),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: FutureBuilder(
        future: paymentFutureRequest,
        builder: (context, paymentSnapshot) {
          if (paymentSnapshot.connectionState == ConnectionState.done) {
            switch (widget.methodSelectorIndex) {
              case 0:
                return TransferForm(
                  transferBankAccounts: paymentSnapshot
                      .data?.bankAccountResponse?.transferBankAccounts,
                  exchangeRate: paymentSnapshot.data?.exchangeRateResponse,
                  paymentParams: widget.paymentParams,
                );
              case 1:
                return MobilePayForm(
                  mobilePayBankAccounts: paymentSnapshot
                      .data?.bankAccountResponse?.mobilePayBankAccounts,
                  exchangeRate: paymentSnapshot.data?.exchangeRateResponse,
                  paymentParams: widget.paymentParams,
                );
              case 2:
                return ZelleForm(
                  zelleBankAccounts: paymentSnapshot
                      .data?.bankAccountResponse?.zelleBankAccounts,
                  paymentParams: widget.paymentParams,
                );
              case 3:
                return StripeForm(
                  paymentParams: widget.paymentParams,
                );
              default:
                return const SizedBox();
            }
          } else {
            return CircularLoader(color: AppColors.secondaryColor, size: 40);
          }
        },
      ),
    );
  }
}
