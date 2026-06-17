import 'package:flutter/material.dart';

class DateCard extends StatefulWidget {
  final VoidCallback onPressed;
  final DateTime date;
  const DateCard({super.key, required this.date, required this.onPressed});

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Icon(Icons.calendar_today),
        title: Text("Date"),
        onTap: widget.onPressed,
      ),
    );
  }
}
