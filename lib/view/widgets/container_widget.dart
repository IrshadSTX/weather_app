import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.text,
    required this.value,
    required this.unit,
    required this.imageUrl,
  });
  final String text;
  final String value;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
          width: 70,
          decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 5,
                  color: Colors.grey,
                ),
              ]),
          child: Image.asset(
            'assets/images/$imageUrl',
          ),
        ),
        Text(
          '$value$unit',
          style: const TextStyle(fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
