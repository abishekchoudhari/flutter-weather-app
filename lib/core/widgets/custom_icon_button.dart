import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final double? iconSize;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(iconData),
      color: Colors.white,
      iconSize: iconSize ?? SizeConfig.iconSizeLarge,
    );
  }
}
