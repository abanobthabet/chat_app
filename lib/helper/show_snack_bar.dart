  import 'package:flutter/material.dart';

void show_massege(
    BuildContext context,{
    required String massege,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(massege)));
  }

