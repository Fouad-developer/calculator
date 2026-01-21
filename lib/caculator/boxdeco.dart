import 'package:flutter/material.dart';

class CalculatorButtonDecorations {
  // Main app background
  static const BoxDecoration appBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF0F172A), Color(0xFF020617)],
    ),
  );

  // Number buttons (0–9, decimal point)
  static BoxDecoration numberButton(BuildContext context) => BoxDecoration(
        color: const Color(0xFF1E293B), // slate-800 with blue tint
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10, width: 0.5),
        boxShadow: [
          const BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 12,
            color: Colors.black45,
          ),
          BoxShadow(
            offset: const Offset(-2, -2),
            blurRadius: 8,
            color: const Color(0xFF334155).withOpacity(0.3),
          ),
        ],
      );

  // Operator buttons (+ − × ÷)
  static BoxDecoration operatorButton(BuildContext context) => BoxDecoration(
        color: const Color(0xFF1E3A8A), // deep navy
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black54,
          ),
        ],
      );

  // Equals button (the hero)
  static BoxDecoration equalsButton(BuildContext context) => BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3B82F6),
            Color(0xFF1D4ED8)
          ], // bright blue → deep blue
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 16,
            color: const Color(0xFF3B82F6).withOpacity(0.6),
          ),
          const BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            color: Colors.black54,
          ),
        ],
      );

  // Clear / AC / C button
  static BoxDecoration clearButton(BuildContext context) => BoxDecoration(
        color: const Color(0xFF475569),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 10,
            color: Colors.black45,
          ),
        ],
      );
}
