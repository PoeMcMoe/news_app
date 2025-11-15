import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/app/context_extensions.dart';

class AppDateRow extends StatelessWidget {
  final DateTime date;

  const AppDateRow({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM d, yyyy • HH:mm');

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          dateFormatter.format(date),
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
