import 'package:flutter/material.dart';

import '../../constant.dart';

class CardDetail extends StatelessWidget {
  CardDetail({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tsW600.copyWith(
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          )
        ],
      ),
    );
  }
}
