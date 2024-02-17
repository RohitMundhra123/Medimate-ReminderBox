import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medbox/widgets/clock/digit.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer? timer;
  String hour1 = "0",
      hour2 = "0",
      minute1 = "0",
      minute2 = "0",
      second1 = "0",
      second2 = "0";
  final df = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final time = DateTime.now();
      final printable = df.format(time);
      final splits = printable.split(":");
      final hour = splits[0];
      final minute = splits[1];
      final second = splits[2];
      if (mounted) {
        setState(() {
          hour1 = hour.characters.first;
        });
      }

      if (mounted) {
        setState(() {
          hour2 = hour.characters.last;
        });
      }
      if (mounted) {
        setState(() {
          minute1 = minute.characters.first;
        });
      }
      if (mounted) {
        setState(() {
          minute2 = minute.characters.last;
        });
      }
      if (mounted) {
        setState(() {
          second1 = second.characters.first;
        });
      }
      if (mounted) {
        setState(() {
          second2 = second.characters.last;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Digit(number: hour1),
        const SizedBox.square(dimension: 10),
        Digit(number: hour2),
        const SizedBox(
          width: 10,
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(
          width: 10,
        ),
        Digit(number: minute1),
        const SizedBox.square(dimension: 10),
        Digit(number: minute2),
        const SizedBox(
          width: 10,
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(
          width: 10,
        ),
        Digit(number: second1),
        const SizedBox.square(dimension: 10),
        Digit(number: second2),
        const Spacer(),
      ],
    );
  }
}
