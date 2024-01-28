import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/fields/custom_date_text_input.dart';
import 'package:ofma_app/components/fields/custom_text_field.dart';
import 'package:ofma_app/components/payment_detail_tile/payment_detail_tile.dart';
import 'package:ofma_app/components/payment_form_title/payment_form_title.dart';
import 'package:ofma_app/components/payment_radio_list_tile/payment_radio_list_tile.dart';
import 'package:ofma_app/data/remote/ofma/orders_request.dart';
import 'package:ofma_app/models/bank_account_response.dart';
import 'package:ofma_app/models/exchange_rate_response.dart';
import 'package:ofma_app/models/payment_params.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/utils/check_ref_and_date.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({
    super.key,
    this.transferBankAccounts,
    required this.paymentParams,
    this.exchangeRate,
  });

  final TransferBankAccounts? transferBankAccounts;
  final ExchangeRateResponse? exchangeRate;
  final PaymentParams paymentParams;

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  late List<Widget> radioListTiles;

  DateTime? date;
  String ref = '';
  int? selectedValue;

  TextEditingController dateInput = TextEditingController();
  TextEditingController refInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setSelectedValue(int value) {
      setState(() {
        selectedValue = value;
      });
    }

    radioListTiles = List.generate(
      widget.transferBankAccounts?.totalCount ?? 0,
      (index) => PaymentRadioListTile(
        selectedValue: selectedValue,
        onChanged: setSelectedValue,
        index: index,
        title: widget.transferBankAccounts?.result?[index].accountAlias ?? '',
        subtitle:
            '${widget.transferBankAccounts?.result?[index].bank?.name ?? ''} (${widget.transferBankAccounts?.result?[index].bank?.code ?? ''})',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentFormTitle(
          title: 'Registrar pago',
          amount: widget.paymentParams.amount,
          exchangeRate: widget.exchangeRate,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Selecciona la cuenta:'),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: radioListTiles,
          ),
        ),
        const SizedBox(height: 20),
        if (selectedValue != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detalles de la cuenta:'),
              const SizedBox(height: 10),
              _TransferDetails(
                  bankAccount:
                      widget.transferBankAccounts?.result?[selectedValue!]),
              const SizedBox(height: 30),
              CustomDateTextInput(
                  dateInput: dateInput,
                  hintText: 'Fecha de compra',
                  icon: Icons.date_range_outlined),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  textInputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  textInputType: TextInputType.number,
                  textEditingController: refInput,
                  hintText: 'Número de referencia',
                  icon: CommunityMaterialIcons.tag_outline),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  width: double.infinity,
                  onTap: () {
                    if (checkRefAndDate(
                      ref: refInput.text,
                      date: dateInput.text,
                    )) {
                      DateFormat format = DateFormat('dd/MM/yyyy');
                      DateTime paidAt = format.parse(dateInput.text);

                      final orderRequest = OrderRequest();
                      context.pushReplacementNamed(
                        AppRouterConstants.loadingPaymentScreen,
                        extra: orderRequest.createOrder(
                          reference: refInput.text,
                          paidAt: paidAt,
                          paymentParams: widget.paymentParams,
                          exchangeRateId: widget.exchangeRate?.id,
                          transferBankAccountId: widget
                              .transferBankAccounts?.result?[selectedValue!].id,
                        ),
                      );
                    }
                  },
                  text: 'Siguiente'),
              const SizedBox(height: 30),
            ],
          )
      ],
    );
  }
}

class _TransferDetails extends StatelessWidget {
  const _TransferDetails({
    this.bankAccount,
  });

  final TransferBankAccountsResult? bankAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DetailTile(
          body: bankAccount?.accountHolderName ?? '',
          icon: CommunityMaterialIcons.account_circle,
          title: 'Beneficiario',
        ),
        const SizedBox(height: 20),
        DetailTile(
          body: bankAccount?.accountNumber ?? '',
          icon: CommunityMaterialIcons.credit_card,
          title: 'Número de cuenta',
        ),
        const SizedBox(height: 20),
        DetailTile(
          body: bankAccount?.accountHolderDocument ?? '',
          icon: CommunityMaterialIcons.wallet,
          title: 'Documento',
        ),
        const SizedBox(height: 20),
        DetailTile(
          body: bankAccount?.accountHolderEmail ?? '',
          icon: CommunityMaterialIcons.email,
          title: 'Email',
        ),
      ]),
    );
  }
}
