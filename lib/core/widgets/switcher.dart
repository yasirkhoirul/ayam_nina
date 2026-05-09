import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int)? onChanged;
  const Switcher({
    super.key,
    required this.options,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        spacing: 5,
        children: [
          ...options.asMap().entries.map((entry) {
            return Expanded(
              child: InkWell(
                onTap: () => onChanged?.call(entry.key),
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: selectedIndex == entry.key
                          ? <Color>[
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ]
                          // PERBAIKAN: Berikan minimal 2 warna agar LinearGradient tidak error
                          : <Color>[Colors.transparent, Colors.transparent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Stack(
                    children: [
                      Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selectedIndex == entry.key
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
