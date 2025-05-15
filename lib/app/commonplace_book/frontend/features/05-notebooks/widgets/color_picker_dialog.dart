// Flutter Imports
import 'package:flutter/material.dart';



class ColorPickerDialog extends StatelessWidget {
  final ValueChanged<Color> onColorSelected;

  const ColorPickerDialog({super.key, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange,
      Colors.purple, Colors.teal, Colors.pink, Colors.brown, Colors.grey,
    ];

    return AlertDialog(
      title: const Text("Selecciona un color"),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // 5 colores por fila
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onColorSelected(colors[index]);
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}