import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class DateCard extends StatefulWidget {
  DateTime? selectedDate;
  TimeOfDay? time;
  final void Function(DateTime?) onDateChanged;
  final void Function(TimeOfDay?) onTimeChanged;

  DateCard({
    super.key,
    required this.selectedDate,
    required this.time,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime(2030),
    );

    setState(() {
      widget.selectedDate = pickedDate;
    });
    widget.onDateChanged(pickedDate);
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(146, 238, 238, 238),
          border: BoxBorder.all(
            color: const Color.fromARGB(199, 238, 238, 238),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.selectedDate == null
                  ? 'dd/mm/aaaa'
                  : '${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}',
              style: TextStyle(color: AppTheme.black),
            ),
            SizedBox(width: 7),
            Icon(Icons.calendar_today, color: AppTheme.black, size: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: widget.time ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        widget.time = time;
      });
      widget.onTimeChanged(time);
    }
  }

  Widget _buildHourPicker() {
    return GestureDetector(
      onTap: _pickTime,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(146, 238, 238, 238),
          border: BoxBorder.all(
            color: const Color.fromARGB(199, 238, 238, 238),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.time == null ? '--:--' : widget.time!.format(context),
              style: TextStyle(color: AppTheme.black),
            ),
            SizedBox(width: 7),
            Icon(Icons.access_time, color: AppTheme.black, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Date & Time',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildDatePicker(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildHourPicker(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
