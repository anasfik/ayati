import 'package:flutter/material.dart';

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
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  statItem.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                StreamBuilder(
                  stream: statItem.valueStream,
                  builder: (context, state) {
                    return Text(state.data.toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
