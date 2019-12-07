import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/utils/utils.dart';

class newImageMenuWidget extends StatelessWidget {
  final String img;
  final double size;
  final VoidCallback onTap;

  newImageMenuWidget(this.img, this.size, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Image.network(
          img,
          width: size,
          height: size,
        )
      ),
    );
  }
}