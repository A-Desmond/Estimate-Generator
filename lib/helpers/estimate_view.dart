import 'package:estimate/constant/const.dart';
import 'package:estimate/model/estimate.dart';
import 'package:flutter/material.dart';

class EstimateView extends StatelessWidget {
  final Estimate estimate;
  const EstimateView({super.key, required this.estimate});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              estimate.itemName,
              style: textStyle,
            ),
            Text(
              estimate.quantity.toString(),
              style: textStyle,
            ),
            Text(
              estimate.price.toString(),
              style: textStyle,
            ),
            Text(
              estimate.totalCost.toString(),
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
