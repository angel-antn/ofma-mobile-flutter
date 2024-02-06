import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/models/concert_response.dart';
import 'package:ofma_app/models/payment_params.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/not_less_than.dart';

class ConcertBookingPage extends StatefulWidget {
  const ConcertBookingPage({super.key, this.concert, required this.setConcert});

  final Concert? concert;
  final Function setConcert;

  @override
  State<ConcertBookingPage> createState() => __ConcertBookingPageState();
}

class __ConcertBookingPageState extends State<ConcertBookingPage> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    qtyPlus() {
      setState(() {
        if (qty <
            notLessThan(
              lessThan: 0,
              number: (widget.concert?.entriesQty ?? 0) -
                  (widget.concert?.ticketSoldQty ?? 0),
            )) {
          qty++;
        }
      });
    }

    qtyMinus() {
      setState(() {
        if (qty > 1) {
          qty--;
        }
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Información de boleto:',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 3,
                )
              ]),
          child: Row(
            children: [
              const Expanded(
                  child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    FeatherIcons.shoppingBag,
                    size: 18,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Precio del boleto',
                  )
                ]),
              )),
              Expanded(
                  child: Center(
                child: Text(
                    '${(widget.concert?.pricePerEntry ?? '').toString()} USD'),
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Cantidad:',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 3,
                            )
                          ]),
                      child: Row(
                        children: [
                          TouchableOpacity(
                            onTap: () => qtyMinus(),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                FeatherIcons.minus,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(qty.toString()),
                          )),
                          TouchableOpacity(
                            onTap: () => qtyPlus(),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                FeatherIcons.plus,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Total:',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 3,
                            )
                          ]),
                      child: Text(
                          '${((widget.concert?.pricePerEntry ?? 0) * qty).toString()} USD'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (widget.concert?.isOpen == true &&
            notLessThan(
                    lessThan: 0,
                    number: (widget.concert?.entriesQty ?? 0) -
                        (widget.concert?.ticketSoldQty ?? 0)) !=
                0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(notLessThan(
                            lessThan: 0,
                            number: (widget.concert?.entriesQty ?? 0) -
                                (widget.concert?.ticketSoldQty ?? 0)) !=
                        1
                    ? 'Quedan ${notLessThan(lessThan: 0, number: (widget.concert?.entriesQty ?? 0) - (widget.concert?.ticketSoldQty ?? 0))} boletos disponibles'
                    : 'Queda 1 boleto disponible'),
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                width: double.infinity,
                onTap: () => context
                    .pushNamed(
                  AppRouterConstants.paymentScreen,
                  extra: PaymentParams(
                      type: 'boleteria',
                      amount: (widget.concert?.pricePerEntry ?? 0) * qty,
                      concertId: widget.concert?.id ?? '',
                      ticketQty: qty),
                )
                    .then(
                  (_) {
                    widget.setConcert();
                  },
                ),
                text: 'Siguiente',
              ),
            ],
          ),
        if (widget.concert?.isOpen == false)
          const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('La venta de boletos para este concierto'),
                Text('se encuentra cerrada')
              ],
            ),
          ),
        if (widget.concert?.isOpen == true &&
            notLessThan(
                    lessThan: 0,
                    number: (widget.concert?.entriesQty ?? 0) -
                        (widget.concert?.ticketSoldQty ?? 0)) ==
                0)
          const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('Se han agotado los boletos disponibles'),
                Text('para este concierto')
              ],
            ),
          ),
      ],
    );
  }
}
