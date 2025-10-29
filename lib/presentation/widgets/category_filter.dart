import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      '',
      'Brasileira',
      'Japonesa',
      'Italiana',
      'Fast Food',
      'Indiana',
      'Francesa',
      'Mexicana',
      'Saudável'
    ];

    return ListView(
      shrinkWrap: true,
      children: categories
          .map(
            (cat) => ListTile(
          title: Text(cat.isEmpty ? 'Todas' : cat),
          selected: selectedCategory == cat,
          onTap: () {
            onCategorySelected(cat);
            Navigator.pop(context);
          },
        ),
      )
          .toList(),
    );
  }
}
