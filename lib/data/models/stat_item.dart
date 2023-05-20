import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StatItem extends Equatable {
  final String title;
  final IconData icon;
  final Stream<String?> valueStream;

  const StatItem({
    required this.title,
    required this.icon,
    required this.valueStream,
  });

  @override
  List<Object?> get props => [
        title,
        icon,
        valueStream,
      ];
}
