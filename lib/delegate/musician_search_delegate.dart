import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/data/remote/ofma/musician_request.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/to_title_case.dart';

class MuscianSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar músico';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 18);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear_rounded,
            color: AppColors.secondaryColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const _SuggestionImage();
    } else {
      return _SuggestionsTiles(query);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const _SuggestionImage();
    } else {
      return _SuggestionsTiles(query);
    }
  }
}

class _SuggestionsTiles extends StatelessWidget {
  const _SuggestionsTiles(this.query);

  final String query;

  @override
  Widget build(BuildContext context) {
    final musicianRequest = MusicianRequest();
    return FutureBuilder(
      future: musicianRequest.getMusicians(highlighted: false, name: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data?.result?.length ?? 0) > 0) {
            return ListView.builder(
              itemCount: snapshot.data?.result?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () => context.pushNamed(
                          AppRouterConstants.musicianScreen,
                          pathParameters: {
                            "id": snapshot.data?.result?[index].id ?? ''
                          }),
                      subtitle: Row(
                        children: [
                          const Icon(
                            FeatherIcons.alignLeft,
                            size: 16,
                            color: Colors.black26,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Miembro desde ${snapshot.data?.result?[index].startDate?.year ?? "????"}',
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                      trailing:
                          (snapshot.data?.result?[index].isHighlighted ?? false)
                              ? Icon(
                                  Icons.star_border_rounded,
                                  color: AppColors.secondaryColor,
                                )
                              : null,
                      leading: SizedBox(
                        height: 100,
                        width: 80,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: Image.network(
                            (snapshot.data?.result?[index].imageUrl ?? '')
                                .replaceAll(
                              'localhost',
                              (dotenv.env['LOCALHOST_ENVIRON'] ?? ''),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(toTitleCase(
                          snapshot.data?.result?[index].fullname ?? '')),
                    ),
                    const Divider(
                      thickness: 0.25,
                    )
                  ],
                );
              },
            );
          } else {
            return const SizedBox();
          }
        } else {
          return CircularLoader(color: AppColors.primaryColor, size: 50);
        }
      },
    );
  }
}

class _SuggestionImage extends StatelessWidget {
  const _SuggestionImage();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/search_image.svg',
          width: 300,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '¿Interesado en saber más de nuestros musicos?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black45,
          ),
        ),
        const Text(
          'busca sus nombre y averigua más de ellos',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black45,
          ),
        )
      ],
    ));
  }
}
