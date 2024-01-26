import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ofma_app/components/border_painter/border_painter.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Boletos'),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async {},
        height: 200,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 240),
                child: Column(
                  children: [
                    _TicketList(),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: _TicketPageHeader(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Gestiona todos tus boletos',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'desde nuestra aplicación',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 300,
                    child: Divider(
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TicketPageHeader extends StatelessWidget {
  const _TicketPageHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/backgrounds/ticket_background.webp',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration:
              BoxDecoration(color: Colors.deepPurpleAccent.withAlpha(200)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(3))),
                  child: const Text(
                    'Boletos',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    '¡Adquiere tus boletos para vernos en vivo!',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white, overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _TicketList extends StatelessWidget {
  const _TicketList();

  @override
  Widget build(BuildContext context) {
    final controller = SwiperController();
    return SizedBox(
      width: double.infinity,
      height: 575,
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 100)),
        builder: (context, snapshota) {
          if (0 == 1 - 1) {
            return Swiper(
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.purple, width: 2),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 15)
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: CustomPaint(
                            painter: BorderPainter(
                                color: AppColors.purple, thickness: 7.0),
                            child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                      child: QrImageView(data: 'hola')),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SelectableText(
                          'e091b624-f61a-4a1b-ba2d-65a355edeeee',
                          style: TextStyle(color: Colors.black38),
                        ),
                        Divider(
                          color: AppColors.purple,
                        ),
                        Text(
                          'Concierto de navidad',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.purple,
                              fontSize: 22,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.maxFinite,
                          height: 150,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              'http://10.0.2.2:3000/api/file/concert/3db2a134-4a73-48b2-b3a2-054c415e8f02.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '03/12/2024',
                          style: TextStyle(color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 3,
              viewportFraction: 0.8,
              scale: 0.9,
              itemWidth: 380,
              itemHeight: 500,
              loop: false,
              layout: SwiperLayout.TINDER,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.black26,
                    activeColor: AppColors.secondaryColor,
                    size: 6.0,
                    activeSize: 9.0),
              ),
            );
          } else {
            return CircularLoader(color: AppColors.secondaryColor, size: 50);
          }
        },
      ),
    );
  }
}
