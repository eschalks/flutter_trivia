import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class HtmlText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const HtmlText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(HtmlUnescape().convert(text), style: style);
  }


}