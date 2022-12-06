import 'package:flutter/material.dart';

class BigIcon extends StatelessWidget {
  final bool isError;
  final String errorText;
  final IconData icon;
  const BigIcon({super.key, required this.isError, required this.errorText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
              Icon(
                icon,
                size: 84,
                color: isError ? Theme.of(context).errorColor : null,
              ),
              Text(
                errorText,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ])));
  }
}
