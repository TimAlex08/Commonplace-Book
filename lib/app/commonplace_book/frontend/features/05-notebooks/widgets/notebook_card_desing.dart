import 'package:flutter/material.dart';

import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/utils/utils.dart';
import '../../shared/models/models.dart';

class NotebookCardDesing extends StatelessWidget {
  const NotebookCardDesing({
    super.key,
    required this.notebook,
    this.aspectRatio = 0.8,
  });
  
  final NotebookUiModel notebook;
  final double aspectRatio; // Permite personalizar la proporción si es necesario
  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        elevation: 6,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: _buildNotebookContent(),
      ),
    );
  }
  
  Widget _buildNotebookContent() {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          left: 10, // Ajusta esto según sea necesario
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: notebook.color.toColor()
            ),
          ),
        ),
       
        Positioned(
          left: 20,
          top: -10,
          bottom: 0,
          child: CustomPaint(
            size: const Size(15, double.infinity),
            painter: NotebookHolePainter(),
          ),
        ),
       
        Positioned(
          left: 6,
          top: -10,
          bottom: 0,
          child: CustomPaint(
            size: const Size(15, double.infinity),
            painter: NotebookSpiralPainter(),
          )
        ),
       
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                notebook.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: notebook.color.toColor().computeLuminance() > 0.5 ? Colors.black54 : Colors.white70
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}



class NotebookHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 2;
    
    final spacing = size.height / 12;
    
    for (var i = 2; i < 12; i++) {
      final y = spacing * i;
      // Dibujar círculos para simular el espiral
      canvas.drawCircle(Offset(8, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NotebookSpiralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Color plateado para los anillos
    final paint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..style = PaintingStyle.fill;
    
    // Sombra sutil para dar profundidad
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill;
    
    // Brillo para efecto metálico
    final highlightPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;
    
    final spacing = size.height / 12;
    
    // Dimensiones de los anillos rectangulares (proporción 1:5)
    const ringHeight = 5.0;
    const ringWidth = 25.0;
    const radius = ringHeight / 2;
    
    for (var i = 2; i < 12; i++) {
      final y = spacing * i;
      
      // Dibujar sombra ligeramente desplazada
      final shadowRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(8, y + 1), width: ringWidth, height: ringHeight),
        const Radius.circular(radius),
      );
      canvas.drawRRect(shadowRect, shadowPaint);
      
      // Dibujar el anillo plateado
      final ringRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(8, y), width: ringWidth, height: ringHeight),
        const Radius.circular(radius),
      );
      canvas.drawRRect(ringRect, paint);
      
      // Añadir brillo en la parte superior para efecto metálico
      final highlightRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(8 - ringWidth/2, y - ringHeight/2, 8 + ringWidth/2, y - ringHeight/2 + 1.5),
        const Radius.circular(radius),
      );
      canvas.drawRRect(highlightRect, highlightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}