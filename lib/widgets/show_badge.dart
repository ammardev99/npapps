// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ShowBadge extends StatelessWidget {
  int count;
  Color color; 
  double size;
  ShowBadge({
    super.key,
    required this.count,
    this.color = Colors.green,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
    alignment: Alignment.center,
    children: [
      SvgPicture.asset(
        'lib/assets/svg/parah_badge.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      Text(
        count.toString(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    ],
  );
  }
}
