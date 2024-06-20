import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class AsyncContent<T> extends HookWidget {
  final AsyncValue<T> value;
  final Widget Function(T) builder;

  const AsyncContent({required this.value, required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    if (value.hasError) {
      return Center(
          child: Text(
            'Error: ${value.error}',
            style: const TextStyle(color: Colors.red),
          ));
    }

    if (value.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!value.hasValue) {
      return const Center(child: Text('No data'));
    }

    return builder(value.value!);
  }

}