import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmbeddedDatePicker extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime start, DateTime? end) onDateSelected;

  const EmbeddedDatePicker({
    super.key,
    this.startDate,
    this.endDate,
    required this.onDateSelected,
  });

  @override
  State<EmbeddedDatePicker> createState() => _EmbeddedDatePickerState();
}

class _EmbeddedDatePickerState extends State<EmbeddedDatePicker> {
  late DateTime _focusedDate;
  // Use a fixed start year to avoid issues if DateTime.now().year changes or differs
  late final int _currentYear = DateTime.now().year;
  late final List<int> _years = List.generate(
    10,
    (index) => _currentYear + index,
  );

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.startDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(EmbeddedDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If startDate changed externally and is different from current focus, update focus
    if (widget.startDate != null && widget.startDate != oldWidget.startDate) {
      // Optional: decide if we want to jump to the new start date
      // _focusedDate = widget.startDate!;
    }
  }

  void _onDaySelected(DateTime day) {
    // If only start date is selected, or if we are restarting selection
    if (widget.startDate == null ||
        (widget.startDate != null && widget.endDate != null)) {
      widget.onDateSelected(day, null);
    } else if (widget.startDate != null && widget.endDate == null) {
      if (day.isBefore(widget.startDate!)) {
        // Reselect start date if darker than current start
        widget.onDateSelected(day, null);
      } else {
        widget.onDateSelected(widget.startDate!, day);
      }
    }
  }

  void _updateFocusedDate(DateTime newDate) {
    setState(() {
      _focusedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important for embedding in ScrollView
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDaysHeader(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int displayYear = _focusedDate.year;
    if (!_years.contains(displayYear)) {
      if (displayYear < _years.first) displayYear = _years.first;
      if (displayYear > _years.last) displayYear = _years.last;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () => _updateFocusedDate(
            DateTime(_focusedDate.year, _focusedDate.month - 1),
          ),
        ),
        Row(
          children: [
            _buildDropdown<int>(
              value: _focusedDate.month,
              items: List.generate(12, (index) => index + 1),
              textBuilder: (month) =>
                  DateFormat('MMM').format(DateTime(2024, month)),
              onChanged: (val) {
                if (val != null)
                  _updateFocusedDate(DateTime(_focusedDate.year, val));
              },
            ),
            const SizedBox(width: 8),
            _buildDropdown<int>(
              value: displayYear,
              items: _years,
              textBuilder: (year) => year.toString(),
              onChanged: (val) {
                if (val != null)
                  _updateFocusedDate(DateTime(val, _focusedDate.month));
              },
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () => _updateFocusedDate(
            DateTime(_focusedDate.year, _focusedDate.month + 1),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required String Function(T) textBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<T>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(textBuilder(e))))
            .toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
        icon: const Icon(Icons.expand_more, size: 18),
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        isDense: true,
      ),
    );
  }

  Widget _buildDaysHeader() {
    final days = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map(
            (e) => SizedBox(
              width: 32,
              child: Text(
                e,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(
      _focusedDate.year,
      _focusedDate.month + 1,
      0,
    ).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);

    // weekday returns 1 for Monday, 7 for Sunday
    // if our grid starts on Sunday (index 0), we want Sunday=0, Monday=1, etc.
    // If DateTime.weekday: Mon=1,... Sun=7.
    // So Sunday should be offset 0. Mon=1.
    final startingWeekday = firstDayOfMonth.weekday;
    final offset = startingWeekday == 7 ? 0 : startingWeekday;

    final totalCells = 42; // 6 rows * 7

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < offset) {
          return const SizedBox();
        }

        final day = index - offset + 1;
        if (day > daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(_focusedDate.year, _focusedDate.month, day);
        return _buildDayCell(date);
      },
    );
  }

  Widget _buildDayCell(DateTime date) {
    bool isSelected = false;
    bool isRange = false;

    // Normalize dates to remove time for comparison
    final simpleDate = DateTime(date.year, date.month, date.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isPast = simpleDate.isBefore(today);

    final simpleStart = widget.startDate != null
        ? DateTime(
            widget.startDate!.year,
            widget.startDate!.month,
            widget.startDate!.day,
          )
        : null;
    final simpleEnd = widget.endDate != null
        ? DateTime(
            widget.endDate!.year,
            widget.endDate!.month,
            widget.endDate!.day,
          )
        : null;

    if (simpleStart != null) {
      if (simpleDate.isAtSameMomentAs(simpleStart)) {
        isSelected = true;
      }
      if (simpleEnd != null) {
        if (simpleDate.isAtSameMomentAs(simpleEnd)) {
          isSelected = true;
        }
        if (simpleDate.isAfter(simpleStart) && simpleDate.isBefore(simpleEnd)) {
          isRange = true;
        }
      }
    }

    return GestureDetector(
      onTap: isPast ? null : () => _onDaySelected(date),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0F4B38)
              : (isRange ? const Color(0xFFE8F5E9) : Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isPast ? Colors.grey[400] : Colors.black87),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
