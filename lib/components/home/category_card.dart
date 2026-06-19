import 'package:flutter/material.dart';
import 'package:nexo_app/core/theme/app_colors.dart';
import 'package:nexo_app/models/categories.dart';

class CategoryCard extends StatefulWidget {
  final Categories categories;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.categories,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.categories.icon, size: 40),
              const SizedBox(height: 8),
              Text(widget.categories.name),
            ],
          ),
        ),
      ),
    );
  }
}
