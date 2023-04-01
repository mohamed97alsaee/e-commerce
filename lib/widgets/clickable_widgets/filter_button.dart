import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.isSelected,
      this.onSelectColor = selectedFilterColor});
  final bool isSelected;
  final String title;
  final Color onSelectColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          // width: size.width * 0.29,
          height: 30,
          decoration: BoxDecoration(
            color: isSelected ? onSelectColor : lightGreyColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: isSelected ? lightWihteColor : darkGreyColor,
                  fontSize: 14),
            )),
          ),
        ),
      ),
    );
  }
}
