import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:budgetink/main.dart';

class HeatmapCalendarWidget extends StatefulWidget {
  @override
  _HeatmapCalendarWidgetState createState() => _HeatmapCalendarWidgetState();
}

class _HeatmapCalendarWidgetState extends State<HeatmapCalendarWidget> {
  DateTime displayedMonth = DateTime.now();
  Map<DateTime, int> data = {};

  void updateData(double income) {
    DateTime today = DateTime.now();
    data[today] = income.toInt();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorsets = {
      1: Colors.green[100]!,
      10: Colors.green[300]!,
      30: Colors.green[500]!,
    };

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swiped right, go to previous month
          setState(() {
            displayedMonth =
                DateTime(displayedMonth.year, displayedMonth.month - 1);
          });
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swiped left, go to next month
          setState(() {
            displayedMonth =
                DateTime(displayedMonth.year, displayedMonth.month + 1);
          });
        }
      },
      child: GestureDetector(
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025),
          );
          if (selectedDate != null) {
            int? dataValue = await showDialog<int>(
              context: context,
              builder: (BuildContext context) {
                return NumberInputDialog();
              },
            );
            if (dataValue != null) {
              setState(() {
                data[selectedDate] = dataValue;
              });
            }
          }
        },
        child: HeatMapCalendar(
          datasets: data,
          colorsets: colorsets,
        ),
      ),
    );
  }
}

class NumberInputDialog extends StatefulWidget {
  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter data'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(int.tryParse(_controller.text));
          },
        ),
      ],
    );
  }
}
