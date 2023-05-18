import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingItem extends Equatable {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? successText;
  final String? errorText;

  const SettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.successText,
    required this.errorText,
  });

  @override
  List<Object?> get props => [icon, title, onTap, successText, errorText];

  SettingItem copyWith({
    IconData? icon,
    String? title,
    VoidCallback? onTap,
    String? successText,
    String? errorText,
  }) {
    return SettingItem(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
      successText: successText ?? this.successText,
      errorText: errorText ?? this.errorText,
    );
  }
}
