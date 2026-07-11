import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/ui/design_system.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double blur;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.blur = DesignSystem.kBlurMedium,
    this.borderRadius = DesignSystem.kRadiusCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? ThemeDefine.kGlassDark : ThemeDefine.kGlassLight;
    final borderColor =
        isDark ? ThemeDefine.kGlassBorderDark : ThemeDefine.kGlassBorderLight;
    final shadow =
        isDark ? DesignSystem.kGlassShadowDark : DesignSystem.kGlassShadowLight;

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor),
            boxShadow: shadow,
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }
    return card;
  }
}
