import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/secondary_button.dart';
import 'package:ofma_app/components/content_musician_list/content_musician_list.dart';
import 'package:ofma_app/data/remote/ofma/content_request.dart';
import 'package:ofma_app/models/content_response.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/utils/to_title_case.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExclusiveContentDetailsScreen extends StatefulWidget {
  const ExclusiveContentDetailsScreen(
      {super.key, required this.type, required this.id});

  final String type;
  final String id;

  @override
  State<ExclusiveContentDetailsScreen> createState() =>
      _ExclusiveContentDetailsScreenState();
}

class _ExclusiveContentDetailsScreenState
    extends State<ExclusiveContentDetailsScreen> {
  late Future<Content?> contentFutureRequest;
  @override
  void initState() {
    final contentRequest = ContentRequest();
    contentFutureRequest = contentRequest.getContentById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(toTitleCase(widget.type)),
      ),
      body: FutureBuilder(
        future: contentFutureRequest,
        builder:
            (BuildContext context, AsyncSnapshot<Content?> contentSnapshot) {
          return _ExclusiveContentPage(
            type: widget.type,
            exclusiveContent: contentSnapshot.data,
            connectionState: contentSnapshot.connectionState,
          );
        },
      ),
    );
  }
}

class _ExclusiveContentPage extends StatelessWidget {
  const _ExclusiveContentPage({
    required this.type,
    this.exclusiveContent,
    required this.connectionState,
  });

  final String type;
  final Content? exclusiveContent;
  final ConnectionState connectionState;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        ignoreContainers: true,
        enabled:
            exclusiveContent == null || connectionState != ConnectionState.done,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ExclusiveContentHeader(
                  exclusiveContent: exclusiveContent, type: type),
              _ExclusiveContentBody(exclusiveContent: exclusiveContent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ContentMusiciansList(
                    musicians:
                        exclusiveContent?.exclusiveContentMusician ?? []),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}

class _ExclusiveContentBody extends StatelessWidget {
  const _ExclusiveContentBody({
    required this.exclusiveContent,
  });

  final Content? exclusiveContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(5, 5), color: Colors.black12, blurRadius: 15)
            ],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exclusiveContent?.name ?? 'Lorem ipsum' * 10,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            SecondaryButton(
                width: double.infinity,
                onTap: () {
                  context.pushNamed(
                    AppRouterConstants.videoPlayerScreen,
                    extra: (exclusiveContent?.videoUrl ?? '').replaceAll(
                      'localhost',
                      (dotenv.env['LOCALHOST_ENVIRON'] ?? ''),
                    ),
                  );
                },
                text: 'Ver video'),
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Icon(
                  Icons.format_indent_increase,
                  size: 16,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Descripción'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(exclusiveContent?.description ?? 'Lorem ipsum ' * 20)
          ],
        ),
      ),
    );
  }
}

class _ExclusiveContentHeader extends StatelessWidget {
  const _ExclusiveContentHeader({
    required this.exclusiveContent,
    required this.type,
  });

  final Content? exclusiveContent;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: double.maxFinite,
          child: Image.network(
            (exclusiveContent?.imageUrl ??
                    'https://images.unsplash.com/photo-1465847899084-d164df4dedc6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
                .replaceAll(
                    'localhost', (dotenv.env['LOCALHOST_ENVIRON'] ?? '')),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: type == 'concierto'
                  ? Colors.pinkAccent.withAlpha(200)
                  : Colors.orange.withAlpha(200),
            ),
            height: 50,
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(3))),
                  child: Text(
                    toTitleCase(type),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    exclusiveContent?.name ?? 'Lorem Ipsum',
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white, overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
