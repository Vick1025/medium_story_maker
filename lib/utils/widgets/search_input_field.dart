import 'package:flutter/material.dart';

class SearchInputField extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;

  const SearchInputField({
    super.key,
    required this.onSearch,
    required this.hintText,
  });

  @override
  SearchInputFieldState createState() => SearchInputFieldState();
}

class SearchInputFieldState extends State<SearchInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            widget.onSearch(_controller.text);
          },
        ),
      ],
    );
  }
}
