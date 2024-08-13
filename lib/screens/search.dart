import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/widgets/Input.dart';
import 'package:weather_stable/widgets/list_items.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: gradient(),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]),
              child: const Input(),
            ),
            const SizedBox(
              height: 30,
            ),
            const ListItems()
          ],
        ),
      ),
    );
  }
}
