// Flutter Imports
import 'package:flutter/material.dart';



/// Convierte un string hexadecimal en formato #RRGGBB a un entero decimal 0xAARRGGBB con Alfa FF
int hexRGBtoColorInt(String hex) {
  // Elimina el símbolo # si existe
  if (hex.startsWith('#')) {
    hex = hex.substring(1);
  }

  // Verifica longitud válida y procesa
  if (hex.length == 6) {
    hex = 'FF$hex';
  } else if (hex.length != 8) {
    throw FormatException('The color must have 6 (RRGGBB) or 8 (AARRGGBB) hexadecimal characters.');
  }

  return int.parse(hex, radix: 16);
}



/// Convierte un valor entero a un String hexadecimal con formato #RRGGBB
String colorIntToHexRGB(int colorValue) {
  // Se extrae el valor R, G y B.
  final int r = (colorValue >> 16) & 0xFF; // Se desplaza el valor Hexadecimal 16 bits: FF-AA-BB-CC -> 00-00-FF-AA y ejecuta un AND con 00-00-00-FF. Extrae `RR`
  final int g = (colorValue >> 8) & 0xFF;  // Se desplaza el valor Hexadecimal 8 bits:  FF-AA-BB-CC -> 00-FF-AA-BB y ejecuta un AND con 00-00-00-FF  Extrae `GG`
  final int b = colorValue & 0xFF;         // No se desplaza y ejecuta ANDD con un 00-00-00-FF. Extrae `BB`
  
  // Añade un 0 a la izquierda si el valor solo tiene un digito. Pasa de esto 5 a esto 05
  final String rHex = r.toRadixString(16).padLeft(2, '0'); 
  final String gHex = g.toRadixString(16).padLeft(2, '0');
  final String bHex = b.toRadixString(16).padLeft(2, '0');
  
  final String hexRGB = '#$rHex$gHex$bHex'.toUpperCase(); // Crea cadena de texto con el formato #RRGGBB
  return hexRGB;
}



/// Convierte un objeto `Color` a un valor hexadecimal con formato #RRGGBB
String colorToHex(Color color, {bool includeHash = true}) {
  // Se extrae el valor R, G y B
  final int r = (color.r * 255).round();
  final int g = (color.g * 255).round();
  final int b = (color.b * 255).round();
  
  // Añade un 0 a la izquierda si el valor solo tiene un digito. Pasa de esto 5 a esto 05
  final String rHex = r.toRadixString(16).padLeft(2, '0'); 
  final String gHex = g.toRadixString(16).padLeft(2, '0');
  final String bHex = b.toRadixString(16).padLeft(2, '0');
  
  String prefix = includeHash
    ? '#'
    : '';
    
  final String hexRGB = '$prefix$rHex$gHex$bHex'.toUpperCase(); // Crea cadena de texto con el formato #RRGGBB
  return hexRGB;
}



/// Extensión para String que permite convertir directamente a Color
extension StringColorExtension on String {
  /// Convierte un string hexadecimal a un objeto Color
  /// Siempre maneja el alfa, añadiendo FF si el string solo tiene RGB
  Color toColor() {
    String processedHex = this;
    
    // Remover # si existe
    if (processedHex.startsWith('#')) {
      processedHex = processedHex.substring(1);
    }
    
    // Valida longitud exacta
    if(processedHex.length != 6 && processedHex.length != 8) {
      throw FormatException('The color must have 6 (RRGGBB) or 8 (AARRGGBB) hexadecimal characters.');
    }
    
    // Si solo tiene RGB se asume Alpha como FF
    if(processedHex.length == 6) {
      processedHex = 'FF$processedHex';
    }
    
    return Color(int.parse(processedHex, radix: 16));
  }
}



/// Extensión para Color que permite convertir directamente a hexadecimal
extension ColorExtensions on Color {
  /// Convierte un objeto Color a un string hexadecimal. Siempre incluye el canal alfa
  String toHex({bool includeHash = true}) {
    return colorToHex(this, includeHash: includeHash);
  } 
}