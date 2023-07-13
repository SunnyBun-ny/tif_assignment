import 'package:flutter/material.dart';

extension DeviceSize on BuildContext {
  height(int size) =>
      (MediaQuery.of(this).size.height -
          MediaQuery.of(this).padding.top -
          MediaQuery.of(this).padding.bottom) *
      size /
      800;

  width(int size) => MediaQuery.of(this).size.width * size / 360;
}
