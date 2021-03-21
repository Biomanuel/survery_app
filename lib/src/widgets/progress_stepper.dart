import 'package:flutter/material.dart';

class ProgressStepper extends StatelessWidget {
  const ProgressStepper({
    Key key,
    @required this.curIndex,
    @required this.stepCount,
    @required this.width,
  }) : super(key: key);

  final int curIndex;
  final int stepCount;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(stepCount, (int index) {
        return Container(
          decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
            color: index <= curIndex ? Colors.orangeAccent : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          height: 10.0,
          width: (width - 32.0 - 5.0 * (stepCount - 1)) / stepCount.toDouble(),
          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
        );
      }),
    );
  }
}
