// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ShowBadge extends StatelessWidget {
  final int count;
  final Color color;
  final double size;
  final double scale; // 0.25x, 0.5x, 1x, 1.5x, 2x

  const ShowBadge({
    super.key,
    required this.count,
    this.color = Colors.green,
    this.size = 40,
    this.scale = 1.0, // default is 1x
  });

  @override
  Widget build(BuildContext context) {
    final double scaledSize = size * scale;
    final double textSize = 14 * scale; // base text size 14, scaled

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'lib/assets/svg/parah_badge.svg',
          width: scaledSize,
          height: scaledSize,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            color: color, // usually text inside badge is white
            fontWeight: FontWeight.bold,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
