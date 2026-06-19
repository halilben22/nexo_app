import 'package:flutter/material.dart';
import 'package:nexo_app/core/theme/app_colors.dart';
import 'package:nexo_app/core/theme/app_text_styles.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback onPressed;
  const SaveButton({super.key, required this.onPressed});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.done_sharp, color: AppColors.invertedButton, size: 24),
          Text("Save Transaction", style: AppTextStyles.heading2),
        ],
      ),
    );
  }
}
