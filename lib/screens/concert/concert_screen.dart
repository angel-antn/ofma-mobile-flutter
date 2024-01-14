import 'package:community_material_icon/community_material_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/concertMuscianList/concert_musician_list.dart';
import 'package:ofma_app/data/remote/ofma/concert_request.dart';
import 'package:ofma_app/models/concert_response.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/convert_to_12_hour_format.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ConcertScreen extends StatelessWidget {
  const ConcertScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final concertRequest = ConcertRequest();
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: concertRequest.getConcertById(id),
        builder: (context, concertSnapshot) {
          return _ConcertPage(
            concert: concertSnapshot.data,
          );
        },
      ),
    );
  }
}

class _ConcertPage extends StatelessWidget {
  const _ConcertPage({this.concert});

  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: concert == null,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            _ConcertHeader(concert: concert),
            _ConcertBody(concert: concert)
          ],
        ),
      ),
    );
  }
}

class _ConcertBody extends StatefulWidget {
  const _ConcertBody({
    required this.concert,
  });

  final Concert? concert;

  @override
  State<_ConcertBody> createState() => _ConcertBodyState();
}

class _ConcertBodyState extends State<_ConcertBody> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 280),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _IndexButton(
                    index: 0,
                    currentIndex: currentIndex,
                    text: 'Descripción',
                    icon: Icons.info_outline,
                    onTap: () => setState(() {
                      currentIndex = 0;
                    }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _IndexButton(
                    index: 1,
                    currentIndex: currentIndex,
                    text: 'Comprar boletos',
                    icon: CommunityMaterialIcons.ticket_confirmation_outline,
                    onTap: () => setState(() {
                      currentIndex = 1;
                    }),
                  )
                ]),
          ),
          const SizedBox(
            height: 30,
          ),
          if (currentIndex == 0) _ConcertDetails(concert: widget.concert),
          if (currentIndex == 1)
            _ConcertBooking(
              concert: widget.concert,
            )
        ],
      ),
    );
  }
}

class _ConcertBooking extends StatefulWidget {
  const _ConcertBooking({this.concert});

  final Concert? concert;

  @override
  State<_ConcertBooking> createState() => __ConcertBookingState();
}

class __ConcertBookingState extends State<_ConcertBooking> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    qtyPlus() {
      setState(() {
        if (qty < (widget.concert?.entriesQty ?? 0)) {
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
            'Informacíon de boleto:',
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
          height: 50,
        ),
        PrimaryButton(width: double.infinity, onTap: () {}, text: 'Siguiente')
      ],
    );
  }
}

class _ConcertDetails extends StatelessWidget {
  const _ConcertDetails({
    this.concert,
  });

  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          concert?.description ?? 'lorem ipsum ' * 40,
        ),
        const SizedBox(
          height: 20,
        ),
        ConcertMusiciansList(musicians: concert?.concertMusician ?? [])
      ],
    );
  }
}

class _IndexButton extends StatelessWidget {
  const _IndexButton(
      {required this.index,
      required this.currentIndex,
      required this.text,
      required this.icon,
      required this.onTap});

  final int index;
  final int currentIndex;
  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TouchableOpacity(
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Easing.emphasizedDecelerate,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.secondaryColor
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: index == currentIndex ? Colors.white : Colors.black26,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  color: index == currentIndex ? Colors.white : Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ConcertHeader extends StatelessWidget {
  const _ConcertHeader({
    required this.concert,
  });

  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          (concert?.imageUrl ??
                  'https://cdn.pixabay.com/photo/2016/11/19/09/57/violins-1838390_1280.jpg')
              .replaceAll('localhost', '10.0.2.2'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.purple[900]!.withAlpha(150),
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.black54,
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                TouchableOpacity(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  concert?.name ?? 'Lorem ipsum',
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.calendar_range_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${concert?.startDate?.day}/${concert?.startDate?.month}/${concert?.startDate?.year}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ]),
                const SizedBox(
                  height: 5,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.clock_time_eleven_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    convertTo12HourFormat(concert?.startAtHour ?? '00:00:00'),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ]),
                const SizedBox(
                  height: 5,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.map_marker_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    concert?.address ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}