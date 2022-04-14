import 'package:flutter/material.dart';

/// Responsive widget.
///
/// This widget is used to build responsive widgets.
///
/// Queries for diferent screen sizes are:
///
/// * Mobile:  width <= 767
/// * Tablet: width >= 768 && width < 1024
/// * Desktop: width >= 1024
///
/// Mobile widget is required.
/// If no tablet widget is provided, the mobile widget will be used.
/// If no desktop widget is provided, the tablet widget will be used.

class ResponsiveWidget extends StatelessWidget {
  final Widget _mobile;
  final Widget _tablet;
  final Widget _desktop;

  const ResponsiveWidget({
    Key? key,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  })  : _mobile = mobile,
        _tablet = tablet ?? mobile,
        _desktop = desktop ?? mobile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 767) {
      return _mobile;
    }
    if (width >= 768 && width < 1024) {
      return _tablet;
    }
    return _desktop;
  }
}
