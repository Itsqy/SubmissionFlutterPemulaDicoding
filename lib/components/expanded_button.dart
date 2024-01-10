import 'package:flutter/material.dart';

class ExpandingButton extends StatefulWidget {
  const ExpandingButton({Key? key}) : super(key: key);

  @override
  _ExpandingButtonState createState() => _ExpandingButtonState();
}

class _ExpandingButtonState extends State<ExpandingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  final double _buttonWidth = 50.0;
  bool isTextFieldVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // Initialize the animation without MediaQuery here
    _widthAnimation = Tween<double>(begin: _buttonWidth, end: _buttonWidth)
        .animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access MediaQuery safely within didChangeDependencies
    final screenWidth = MediaQuery.of(context).size.width - 16;
    _widthAnimation = Tween<double>(begin: _buttonWidth, end: screenWidth)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _controller.forward(); // Always expand on tap
            setState(() {
              isTextFieldVisible = true;
            });
          },
          child: Container(
            width: _widthAnimation.value,
            margin: !isTextFieldVisible
                ? const EdgeInsets.only(right: 8.0)
                : const EdgeInsets.only(left: 8, right: 8),
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: isTextFieldVisible
                ? const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter text here',
                      icon: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
