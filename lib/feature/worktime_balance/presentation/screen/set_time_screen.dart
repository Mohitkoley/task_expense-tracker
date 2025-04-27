import 'package:bloc_test/core/export/global_export.dart';
import 'package:bloc_test/feature/worktime_balance/presentation/bloc/time_selection_bloc.dart';
import 'package:bloc_test/feature/worktime_balance/presentation/bloc/time_selection_event.dart';
import 'package:bloc_test/feature/worktime_balance/presentation/bloc/time_selection_state.dart';
import 'package:bloc_test/feature/worktime_balance/presentation/widget/time_picker_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetTimeScreen extends StatelessWidget {
  const SetTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Scheduler')),
      body: BlocConsumer<TimeSelectionBloc, TimeSelectionState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimePickerButton(
                    time: state.startTime,
                    label: 'Start Time',
                    onTimeSelected: (time) => context
                        .read<TimeSelectionBloc>()
                        .add(StartTimeSelected(time)),
                  ),
                  const SizedBox(height: 20),
                  TimePickerButton(
                    time: state.endTime,
                    label: 'End Time',
                    onTimeSelected: (time) => context
                        .read<TimeSelectionBloc>()
                        .add(EndTimeSelected(time)),
                  ),
                  const SizedBox(height: 40),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => context
                              .read<TimeSelectionBloc>()
                              .add(ScheduleNotifications()),
                          child: const Text('Schedule Notifications'),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
