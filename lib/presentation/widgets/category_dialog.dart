import 'package:flutter/material.dart';

class CategoryDialog extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryDialog({
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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Selecionar Categoria',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(height: 1),
            ...categories.map((cat) {
              return ListTile(
                title: Text(cat.isEmpty ? 'Todas' : cat),
                selected: selectedCategory == cat,
                onTap: () {
                  onCategorySelected(cat);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
