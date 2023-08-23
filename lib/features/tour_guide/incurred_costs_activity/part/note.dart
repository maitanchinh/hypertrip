part of '../view.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _controller = TextEditingController();
  IncurredCostsActivityCubit? _cubit;
  int length = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onChange);

    _cubit = context.read<IncurredCostsActivityCubit>();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    _cubit?.onStateChanged(_cubit!.state.copyWith(
      note: _controller.text,
      isNoteValid: _controller.text.isNotEmpty,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IncurredCostsActivityCubit, IncurredCostsActivityState>(
      listener: (context, state) {
        if (state.note != _controller.text) {
          _controller.text = state.note;
          length = state.note.length;
          _controller.selection =
              TextSelection.collapsed(offset: state.note.length);
        }
      },
      child: TextFormField(
        controller: _controller,
        maxLength: IncurredCostsActivityState.maxNoteLength,
        maxLines: 5,
        minLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
