import 'package:flutter/material.dart';

class TajweedText extends StatelessWidget {
  const TajweedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.baseColor,
    this.textAlign = TextAlign.right,
    this.tajweedColors,
  });

  final String text;
  final double fontSize;
  final Color baseColor;
  final TextAlign textAlign;
  final Map<String, Color>? tajweedColors;

  static const Map<String, Color> defaultColors = {
    'h': Color(0xFFAAAAAA),
    's': Color(0xFFAAAAAA),
    'l': Color(0xFFAAAAAA),
    'n': Color(0xFF537FFF),
    'p': Color(0xFF4050FF),
    'm': Color(0xFF000EBC),
    'q': Color(0xFFDD0008),
    'o': Color(0xFF2144C1),
    'c': Color(0xFFD500B7),
    'f': Color(0xFF9400A8),
    'w': Color(0xFF58B800),
    'i': Color(0xFF26BFFD),
    'a': Color(0xFF169777),
    'u': Color(0xFF169200),
    'd': Color(0xFFA1A1A1),
    'b': Color(0xFFA1A1A1),
    'g': Color(0xFFFF7E1E),
  };

  @override
  Widget build(BuildContext context) {
    final colors = tajweedColors ?? defaultColors;
    final spans = _parse(text)
        .map(
          (piece) => TextSpan(
            text: piece.content,
            style: TextStyle(
              color: piece.key == null ? baseColor : colors[piece.key] ?? baseColor,
              height: 2,
            ),
          ),
        )
        .toList();

    return RichText(
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: TextStyle(fontSize: fontSize, fontFamily: 'serif'),
        children: spans,
      ),
    );
  }

  List<_TajweedPiece> _parse(String source) {
    final regex = RegExp(r'\[(\w)(?::\d+)?\[(.*?)\]\]');
    final matches = regex.allMatches(source);
    if (matches.isEmpty) {
      return [_TajweedPiece(content: source, key: null)];
    }

    final output = <_TajweedPiece>[];
    var lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        output.add(
          _TajweedPiece(content: source.substring(lastIndex, match.start), key: null),
        );
      }

      output.add(
        _TajweedPiece(content: match.group(2) ?? '', key: match.group(1)),
      );
      lastIndex = match.end;
    }

    if (lastIndex < source.length) {
      output.add(_TajweedPiece(content: source.substring(lastIndex), key: null));
    }

    return output;
  }
}

class _TajweedPiece {
  const _TajweedPiece({required this.content, required this.key});

  final String content;
  final String? key;
}