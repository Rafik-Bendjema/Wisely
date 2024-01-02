import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/Dialogs/LongPressDialog.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/Source/presentation/widgets/SourceCard.dart';

class SourcesList extends StatefulWidget {
  const SourcesList({super.key});

  @override
  State<SourcesList> createState() => _SourcesListState();
}

class _SourcesListState extends State<SourcesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          List<Source> sources = ref.watch(sourceProvider);
          if (sources.isEmpty) {
            return Expanded(
                child: Container(
              child: Center(
                  child: Text(
                "no Source found",
                style: TextStyle(fontSize: 48, color: primary_color),
              )),
            ));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (BuildContext context, int index) {
              Source currentSource = sources[index];
              return Row(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, currentSource, context)));
                    },
                    child: SourceCard(
                      key: ValueKey(currentSource.toMap()),
                      source: currentSource,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
