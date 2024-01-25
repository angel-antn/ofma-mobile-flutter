import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/data/remote/ofma/orders_request.dart';
import 'package:ofma_app/models/orders_response.dart';
import 'package:ofma_app/theme/app_colors.dart';
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
                const _OrdersBodyTitle(),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Text(order?.id ?? ''),
    );
  }
}

class _OrdersBodyTitle extends StatelessWidget {
  const _OrdersBodyTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Órdenes',
          style: TextStyle(fontSize: 18),
        ),
        Container()
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
        'assets/backgrounds/unused.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}
