import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/data/remote/ofma/orders_request.dart';
import 'package:ofma_app/models/orders_response.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/to_title_case.dart';
import 'package:pagination_flutter/pagination.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<OrdersResponse?> ordersFutureRequest;
  int page = 1;

  @override
  void initState() {
    final OrderRequest orderRequest = OrderRequest();
    ordersFutureRequest = orderRequest.getOrdersByUser(page: page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    handleRefresh() {
      final OrderRequest orderRequest = OrderRequest();
      setState(() {
        page = 1;
        ordersFutureRequest = orderRequest.getOrdersByUser(page: page);
      });
    }

    changePage(int newPage) {
      final OrderRequest orderRequest = OrderRequest();
      setState(() {
        page = newPage;
        ordersFutureRequest = orderRequest.getOrdersByUser(page: page);
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: const Text('Órdenes')),
      body: LiquidPullToRefresh(
        height: 200,
        onRefresh: () async => handleRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              const _OrdersHeader(),
              _OrdersBody(
                ordersFutureRequest: ordersFutureRequest,
                onChangePage: changePage,
                page: page,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrdersBody extends StatelessWidget {
  const _OrdersBody({
    required this.ordersFutureRequest,
    required this.onChangePage,
    required this.page,
  });

  final int page;
  final Future<OrdersResponse?> ordersFutureRequest;
  final Function onChangePage;

  final BoxDecoration boxDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, -15),
        blurRadius: 10,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 180),
      padding: const EdgeInsets.all(40),
      width: double.maxFinite,
      decoration: boxDecoration,
      child: FutureBuilder(
        future: ordersFutureRequest,
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState != ConnectionState.done) {
            return CircularLoader(color: AppColors.secondaryColor, size: 30);
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _OrdersBodyTitle(
                  page: page,
                  maxPage: ((orderSnapshot.data?.totalCount ?? 0) /
                          (orderSnapshot.data?.pageSize ?? 1))
                      .ceil(),
                ),
                const SizedBox(height: 20),
                _OrdersList(orders: orderSnapshot.data),
                Builder(builder: (context) {
                  return Pagination(
                    numOfPages: ((orderSnapshot.data?.totalCount ?? 0) /
                            (orderSnapshot.data?.pageSize ?? 1))
                        .ceil(),
                    selectedPage: page,
                    pagesVisible: 3,
                    onPageChanged: (page) => onChangePage(page),
                    activeTextStyle: TextStyle(color: AppColors.secondaryColor),
                    activeBtnStyle: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: AppColors.secondaryColor),
                      ),
                    ),
                    inactiveTextStyle: const TextStyle(color: Colors.black38),
                    inactiveBtnStyle: const ButtonStyle(),
                    nextIcon: Icon(
                      FeatherIcons.chevronRight,
                      color: AppColors.secondaryColor,
                    ),
                    previousIcon: Icon(
                      FeatherIcons.chevronLeft,
                      color: AppColors.secondaryColor,
                    ),
                  );
                }),
              ],
            );
          }
        },
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({this.orders});

  final OrdersResponse? orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders?.result?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _OrderItem(order: orders?.result?[index]);
      },
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    this.order,
  });

  final Order? order;

  Color getStatusColor(String status) {
    switch (status) {
      case 'verificado':
        return AppColors.green;
      case 'rechazado':
        return AppColors.red;
      case 'pendiente':
        return AppColors.yellow;
      default:
        return Colors.black26;
    }
  }

  String getPaymentMethod(Order? order) {
    if (order?.mobilePayBankAccount != null) {
      return 'Págo movil';
    } else if (order?.transferBankAccount != null) {
      return 'Transferencia';
    } else if (order?.zelleBankAccount != null) {
      return 'Zelle';
    } else {
      return 'Tarjeta de crédito/débito';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OrderItemTitle(order: order),
          const SizedBox(
            height: 20,
          ),
          const _OrderItemField(
            icon: FeatherIcons.list,
            text: 'N° de orden:',
          ),
          SelectableText(order?.id ?? ''),
          const SizedBox(
            height: 20,
          ),
          const _OrderItemField(
            icon: FeatherIcons.archive,
            text: 'Metodo de págo:',
          ),
          Text(getPaymentMethod(order)),
          const SizedBox(
            height: 20,
          ),
          const _OrderItemField(
            icon: FeatherIcons.link,
            text: 'Referencia:',
          ),
          Text(order?.reference ?? ''),
          const SizedBox(
            height: 20,
          ),
          const _OrderItemField(
            icon: FeatherIcons.barChart2,
            text: 'Estatus:',
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 15,
                decoration: BoxDecoration(
                    color: getStatusColor(order?.status ?? ''),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
              ),
              const SizedBox(
                width: 7.5,
              ),
              Text(toTitleCase(order?.status ?? '')),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderItemTitle extends StatelessWidget {
  const _OrderItemTitle({
    required this.order,
  });

  final Order? order;

  Color getTypeColor(String type) {
    switch (type) {
      case 'suscripcion':
        return Colors.orange;
      case 'boleteria':
        return Colors.pinkAccent;
      default:
        return Colors.black38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              border: Border.all(color: getTypeColor(order?.type ?? ''))),
          child: Text(
            toTitleCase(order?.type ?? ''),
            style: TextStyle(color: getTypeColor(order?.type ?? '')),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(2))),
            child: Text(
              '\$${order?.amount ?? 0.00}',
              style: const TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

class _OrderItemField extends StatelessWidget {
  const _OrderItemField({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.secondaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text)
      ],
    );
  }
}

class _OrdersBodyTitle extends StatelessWidget {
  const _OrdersBodyTitle({required this.maxPage, required this.page});

  final int maxPage;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Órdenes',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Text('Página $page de $maxPage'),
        )
      ],
    );
  }
}

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 200,
      child: Image.asset(
        'assets/backgrounds/orders_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}
