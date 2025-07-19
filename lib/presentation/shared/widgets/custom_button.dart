import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatefulWidget {
  final double? height;
  final double? width;
  final String? text;
  final bool isLoading;
  final Color? backgroundColor;
  final double? borderRadius;
  final GestureTapCallback? onTap;
  final Image? image;

  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.image,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Widget _buildChild() {
    if (widget.isLoading) {
      return CupertinoActivityIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
      );
    } else if (widget.image != null) {
      return widget.image!;
    } else if (widget.text != null) {
      return Text(
        widget.text!,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
      );
    } else {
      return const SizedBox.shrink(); // Return an empty widget if no content is provided
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        width: widget.width ?? 200 * scaleFactor,
        height: widget.height ?? 48 * scaleFactor,
        decoration: BoxDecoration(
          color:
              widget.isLoading
                  ? Theme.of(context).focusColor
                  : widget.backgroundColor ??
                      Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
        ),
        child: Center(child: _buildChild()),
      ),
    );
  }
}
