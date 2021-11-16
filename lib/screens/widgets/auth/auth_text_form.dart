import 'package:flutter/material.dart';

class AuthTextForm extends StatefulWidget {
  final String title;
  final String? hints;
  final String? initValue;
  final bool enable;
  final ValueChanged<String>? onChanged;

  const AuthTextForm({
    Key? key,
    required this.title,
    this.hints,
    this.initValue,
    this.enable = true,
    this.onChanged,
  }) : super(key: key);

  @override
  _AuthTextFormState createState() => _AuthTextFormState();
}

class _AuthTextFormState extends State<AuthTextForm> {
  late String text;

  late TextEditingController _controller;

  @override
  void initState() {
    text = widget.initValue ?? '';
    _controller = TextEditingController(text: widget.initValue);
    _controller.addListener(
      () => setState(() {
        text = _controller.text;
        widget.onChanged?.call(text);
      }),
    );
    super.initState();
  }

  int get currentWords => _controller.text.length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            hintText: widget.hints ?? '',
          ),
          controller: _controller,
          maxLines: 1,
          enabled: widget.enable,
          onChanged: (_) {},
        ),
        Container(height: 1, color: Colors.grey[800]),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Please input ${widget.title}',
            style: TextStyle(
              color:
                  currentWords > 0 ? Colors.transparent : Colors.redAccent[100],
            ),
          ),
        ),
      ],
    );
  }
}
