import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final void Function()? onDeleteNote;
  const CustomCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(content), Text(date)],
        ),
        trailing: IconButton(
          onPressed: onDeleteNote,
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}
