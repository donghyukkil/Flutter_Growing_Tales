import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final Color checkColor;
  final Color uncheckedColor;
  final Color borderColor;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.checkColor,
    required this.uncheckedColor,
    required this.borderColor,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });

    // description: The callback function passed from the parent is triggered by the Custom_checkbox. This arrows the _isChecked state in CustomCheckbox to be delivered to the parent widget(DiaryWriteScreen).
    // The parent widget then use setState to update the local variable _isPublic, which is subsequently passed to the ViewModel.

    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: _isChecked ? widget.checkColor : widget.uncheckedColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.borderColor,
            width: 2,
          ),
        ),
        child: _isChecked
            ? Icon(
                Icons.check,
                color: Colors.black,
                size: 18,
              )
            : null,
      ),
    );
  }
}
