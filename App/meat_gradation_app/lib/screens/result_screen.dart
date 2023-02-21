import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> prediction;
  const ResultScreen({super.key, required this.prediction});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
