import 'package:flutter/material.dart';

class ResponsiveAuthLayout extends StatelessWidget {
  final Widget child;
  final bool centerVertically;

  const ResponsiveAuthLayout({
    super.key,
    required this.child,
    this.centerVertically = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isTablet = width >= 600;

        final horizontalPadding = isTablet ? 48.0 : 20.0;

        final maxContentWidth = isTablet ? 520.0 : 430.0;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isTablet ? 32 : 16,
          ),
          child: Align(
            alignment: centerVertically
                ? Alignment.center
                : Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
