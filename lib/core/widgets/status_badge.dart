import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? _colorFor(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: effectiveColor,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Color _colorFor(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('concl') || lower.contains('feito')) {
      return AppColors.success;
    }
    if (lower.contains('atras') || lower.contains('bloq')) {
      return AppColors.danger;
    }
    if (lower.contains('pend') || lower.contains('andamento')) {
      return AppColors.warning;
    }
    return AppColors.primary;
  }
}
