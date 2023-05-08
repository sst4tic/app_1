import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableContainer extends StatefulWidget {
  final String text;
  final Function(bool) onSelected;

  const SelectableContainer({Key? key, required this.text, required this.onSelected}) : super(key: key);

  @override
  SelectableContainerState createState() => SelectableContainerState();
}

class SelectableContainerState extends State<SelectableContainer> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isSelected ? Colors.blue[200] : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: REdgeInsets.all(5),
        child: Text(
          widget.text,
          style: TextStyle(
              color: _isSelected ? Colors.blue[900] : Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
