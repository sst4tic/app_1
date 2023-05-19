import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/styles.dart';

class CustomAnimatedContainer extends StatefulWidget {
  final Widget child;
  final bool isExpanded;
  final String name;
  final VoidCallback onTap;

  const CustomAnimatedContainer({
    Key? key,
    required this.child,
    required this.isExpanded,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  CustomAnimatedContainerState createState() => CustomAnimatedContainerState();
}

class CustomAnimatedContainerState extends State<CustomAnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(CustomAnimatedContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            widget.onTap.call();
          },
          child: Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: widget.isExpanded
                  ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
                  : BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name.toUpperCase(),
                  style: TextStyles.editStyle
                ),
                Icon(
                  widget.isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: SizeTransition(
            sizeFactor: _animation,
            child: widget.isExpanded ? widget.child : Container(),
          ),
        ),
      ],
    );
  }
}
