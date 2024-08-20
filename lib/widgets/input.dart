import 'package:flutter/material.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String) onChange;

  const Input({super.key, this.controller, required this.onChange});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _internalController,
      onChanged: widget.onChange,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0x70FFFFFF),
        prefixIcon: Icon(Icons.search),
        hintText: "Enter city name",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.alphaLight,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00FFFFFF),
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
      ),
    );
  }
}

