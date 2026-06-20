import 'package:flutter/material.dart';
import 'package:nexo_app/core/theme/app_colors.dart';
import 'package:nexo_app/core/theme/app_text_styles.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const SaveButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: widget.isLoading
          ? CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done_sharp,
                  color: AppColors.invertedButton,
                  size: 24,
                ),
                Text("Save Transaction", style: AppTextStyles.heading2),
              ],
            ),
    );
  }
}
