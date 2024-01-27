import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/fields/custom_date_text_input.dart';
import 'package:ofma_app/components/fields/custom_text_field.dart';
import 'package:ofma_app/components/payment_detail_tile/payment_detail_tile.dart';
import 'package:ofma_app/components/payment_form_title/payment_form_title.dart';
import 'package:ofma_app/components/payment_radio_list_tile/payment_radio_list_tile.dart';
import 'package:ofma_app/models/bank_account_response.dart';

class ZelleForm extends StatefulWidget {
  const ZelleForm({
    super.key,
    required this.amount,
    this.zelleBankAccounts,
  });

  final ZelleBankAccounts? zelleBankAccounts;
  final double amount;

  @override
  State<ZelleForm> createState() => _ZelleFormState();
}

class _ZelleFormState extends State<ZelleForm> {
  late List<Widget> radioListTiles;

  DateTime? date;
  String ref = '';
  int? selectedValue;

  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setSelectedValue(int value) {
      setState(() {
        selectedValue = value;
      });
    }

    radioListTiles = List.generate(
      widget.zelleBankAccounts?.totalCount ?? 0,
      (index) => PaymentRadioListTile(
        selectedValue: selectedValue,
        onChanged: setSelectedValue,
        index: index,
        title: widget.zelleBankAccounts?.result?[index].accountAlias ?? '',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentFormTitle(
          title: 'Registrar pago',
          amount: widget.amount,
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
              _ZelleDetails(
                  bankAccount:
                      widget.zelleBankAccounts?.result?[selectedValue!]),
              const SizedBox(height: 30),
              CustomDateTextInput(
                  dateInput: dateInput,
                  hintText: 'Fecha de compra',
                  icon: Icons.date_range_outlined),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                  hintText: 'Número de referencia',
                  icon: CommunityMaterialIcons.tag_outline),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  width: double.infinity, onTap: () {}, text: 'Siguiente'),
              const SizedBox(height: 30),
            ],
          )
      ],
    );
  }
}

class _ZelleDetails extends StatelessWidget {
  const _ZelleDetails({
    this.bankAccount,
  });

  final ZelleBankAccountsResult? bankAccount;

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
          body: bankAccount?.accountHolderEmail ?? '',
          icon: CommunityMaterialIcons.email,
          title: 'Email',
        ),
      ]),
    );
  }
}
