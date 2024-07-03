import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomFilterButton extends StatefulWidget {
  const CustomFilterButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onTap});
  final bool selected;
  final String text;
  final Widget icon;
  final void Function() onTap;

  @override
  State<CustomFilterButton> createState() => _CustomFilterButtonState();
}

class _CustomFilterButtonState extends State<CustomFilterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 32,
        decoration: BoxDecoration(
          color: widget.selected ? const Color(0xff2188FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color:
                widget.selected ? Colors.transparent : const Color(0xffD8DFE6),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            const SizedBox(width: 5),
            Text(widget.text,
                style: AppTextStyle.robotoW500s14.copyWith(
                    color: widget.selected
                        ? const Color(0xffFFFFFF)
                        : const Color(0xff77818C))),
          ],
        ),
      ),
    );
  }
}
