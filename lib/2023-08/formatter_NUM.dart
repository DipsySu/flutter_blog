import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatefulWidget {
  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        DecimalInputFormatter(decimalRange: 2),
      ],
      onChanged: (text) {
        String numberPart = text.split('.').first.replaceAll('，', '');
        double? number = double.tryParse(numberPart);
        if (number != null) {
          String formattedNumber = formatNumberWithChineseComma(number.toInt());
          String decimalPart = text.contains('.') ? text.split('.').last : '';
          if (decimalPart.isNotEmpty) {
            formattedNumber += '.' + decimalPart;
          }
          _controller.value = _controller.value.copyWith(
            text: formattedNumber,
            selection: TextSelection.collapsed(offset: formattedNumber.length),
          );
        }
      },
      decoration: InputDecoration(
        hintText: '请输入数字',
      ),
    );
  }

  String formatNumberWithChineseComma(int number) {
    String numStr = number.toString();
    StringBuffer sb = StringBuffer();
    int count = 0;

    for (int i = numStr.length - 1; i >= 0; i--) {
      sb.write(numStr[i]);
      count++;
      if (count == 3 && i != 0) {
        sb.write('，');
        count = 0;
      }
    }

    return sb.toString().split('').reversed.join('');
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalInputFormatter({required this.decimalRange});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value.contains('..')) {
      value = value.replaceAll('..', '.');
      selectionIndex--;
    }

    if (value != '' && value[0] == '.') {
      value = '0' + value;
      selectionIndex++;
    }

    if (value.contains('.')) {
      String preDecimal = value.split('.').first;
      String postDecimal = value.split('.').last;

      if (postDecimal.length > decimalRange) {
        postDecimal = postDecimal.substring(0, decimalRange);
        value = preDecimal + '.' + postDecimal;
        selectionIndex = oldValue.selection.end;
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}