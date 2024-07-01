import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:flutter/material.dart';

class PumpDetailCard extends StatelessWidget {
  const PumpDetailCard({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title, desc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tsW600.copyWith(fontSize: 14),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              desc,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
