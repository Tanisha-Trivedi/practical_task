import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    this.clearIcon = true,
    this.onFieldSubmitted,
    this.onChanged,
    required this.hintText,
    required this.text,
    this.elevation = 3,
    this.enable = true,
    this.onTap,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final String hintText;
  final String text;
  final double? elevation;
  final GestureTapCallback? onTap;
  final bool clearIcon;
  final bool enable;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        onChanged: widget.onChanged,
        enabled: widget.enable,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          enabled: true,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.search),
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 30,
            maxWidth: 30,
            minHeight: 30,
            minWidth: 30,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 30,
            maxWidth: 30,
            minHeight: 30,
            minWidth: 30,
          ),
          suffixIcon: widget.text.isNotEmpty
              ? InkWell(
                  onTap: () {
                    controller.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 30,
                    width: 30,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                )
              : null,
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.only(
            left: 25,
            top: 5,
          ),
        ),
      ),
    );
  }
}
