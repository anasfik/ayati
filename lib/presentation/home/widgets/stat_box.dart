import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '../../../data/models/stat_item.dart';
import '../../../utils/colors.dart';
import '../../general/margined_body.dart';

class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.statItem,
  });

  final StatItem statItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.green,
          width: 1.2,
        ),
      ),
      child: MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    statItem.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize! +
                                2),
                  ),
                ),
                // const Spacer(),ayahsProgress
                const Icon(
                  FlutterIslamicIcons.quran,
                  color: AppColors.green,
                  size: 28,
                ),
              ],
            ),
            const Spacer(),
            StreamBuilder<String?>(
              stream: statItem.valueStream,
              builder: (context, state) {
                return Text(
                  state.data == null ? '---' : state.data.toString(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                );
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
