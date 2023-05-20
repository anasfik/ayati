import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomBarItem extends Equatable {
  final Widget widget;
  final IconData icon;
  final IconData selectedIcon;

  const BottomBarItem({
    required this.icon,
    required this.widget,
    required this.selectedIcon,
  });

  @override
  List<Object?> get props => [icon, widget, selectedIcon];
}
