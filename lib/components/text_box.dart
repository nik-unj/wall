import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String name;
  final String value;
  final void Function()? onTap;
  const TextBox(
      {super.key, required this.name, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name),
                IconButton(onPressed: onTap, icon: const Icon(Icons.edit))
              ],
            ),
            Text(value)
          ],
        ),
      ),
    );
  }
}
