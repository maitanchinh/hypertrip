part of '../view.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  int noteLength = 0;
  IncurredCostsActivityCubit? _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);
    noteLength = _cubit?.state.noteController.text.length ?? noteLength;

    _cubit?.state.noteController.addListener(() {
      setState(() {
        noteLength = _cubit?.state.noteController.text.length ?? noteLength;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<IncurredCostsActivityCubit>(context).state;

    return TextField(
      controller: state.noteController,
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText:
            'Note ($noteLength/${IncurredCostsActivityState.maxNoteLength})',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
