import 'package:flutter/material.dart';
import 'package:helloflutter/components/animation_expand.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final int minLines;

  const ExpandableText(
      {super.key,
      required this.maxLines,
      required this.minLines,
      required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  Widget expandableText(bool isExpanded) {
    return Text(
      widget.text,
      overflow: TextOverflow.ellipsis,
      maxLines: isExpanded ? widget.maxLines : widget.minLines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          // AnimatedCrossFade uses crossFadeState to determine the tansition between first and second child
          child: AnimatedExpandingContainer(
            isExpanded: _isExpanded,
            // use  true and false below instead of using _isExpanded
            // using _isExpanded will affect the animation tranisition
            expandedWidget: expandableText(true),
            unexpandedWidget: expandableText(false),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  !_isExpanded ? "See More" : "See Less",
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                Icon(
                  !_isExpanded ? Icons.arrow_downward : Icons.arrow_upward,
                  color: Colors.red,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
