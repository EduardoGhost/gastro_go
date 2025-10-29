import 'package:flutter/material.dart';

class SortDialog extends StatelessWidget {
  final String selectedSort;
  final ValueChanged<String> onSortSelected;

  const SortDialog({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['', 'rating', 'distance'];
    final labels = {
      '': 'Nenhum',
      'rating': 'Melhor Avaliação',
      'distance': 'Menor Distância',
    };

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Ordenar por', style: Theme.of(context).textTheme.titleMedium),
            ),
            const Divider(height: 1),
            ...options.map((option) {
              return ListTile(
                title: Text(labels[option]!),
                selected: selectedSort == option,
                onTap: () {
                  onSortSelected(option);
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
