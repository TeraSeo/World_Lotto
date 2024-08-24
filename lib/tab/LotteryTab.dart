import 'package:flutter/material.dart';

class LotteryTab extends StatefulWidget {

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const LotteryTab({required this.text, required this.isSelected, required this.onTap});

  @override
  State<LotteryTab> createState() => _LotteryTabState();
}

class _LotteryTabState extends State<LotteryTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  color: widget.isSelected ? Colors.grey : Colors.white,
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal),
            ),
            if (widget.isSelected)
              Container(
                margin: EdgeInsets.only(top: 4),
                height: 3,
                width: 10,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
