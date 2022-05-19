import 'package:flutter/material.dart';

class BottomButtonListview extends StatefulWidget {
  final List<Widget> children;
  final Function onButtonPressed;
  final bool? loadingMore;
  final ScrollPhysics? scrollPhysics;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? buttonLabel;
  final bool? disableMoreButton;

  const BottomButtonListview(
      {Key? key,
      required this.children,
      this.scrollPhysics,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      required this.onButtonPressed,
      this.buttonLabel,
      this.loadingMore,
      this.disableMoreButton})
      : super(key: key);

  @override
  State<BottomButtonListview> createState() => _BottomButtonListviewState();
}

class _BottomButtonListviewState extends State<BottomButtonListview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: widget.scrollPhysics,
      //wrapper column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //children column
          Column(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                widget.crossAxisAlignment ?? CrossAxisAlignment.start,
            children: widget.children,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: widget.loadingMore == true
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: widget.disableMoreButton == null ||
                              widget.disableMoreButton == false
                          ? () {
                              widget.onButtonPressed();
                            }
                          : null,
                      child: Text(widget.buttonLabel ?? 'More')),
            ),
          )
        ],
      ),
    );
  }
}
