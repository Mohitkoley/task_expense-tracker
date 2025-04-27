import 'package:bloc_test/core/export/global_export.dart';

class TimePickerButton extends StatelessWidget {
  final TimeOfDay? time;
  final String label;
  final Function(TimeOfDay) onTimeSelected;

  const TimePickerButton({
    super.key,
    required this.time,
    required this.label,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) onTimeSelected(picked);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, color: Theme.of(context).primaryColor),
            const SizedBox(width: 10),
            Text(
              time?.format(context) ?? 'Select $label',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
