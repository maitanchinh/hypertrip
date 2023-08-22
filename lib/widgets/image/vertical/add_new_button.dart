part of 'image_vertical_list.dart';

class AddNewButton extends StatefulWidget {
  final Function() onTap;
  const AddNewButton({super.key, required this.onTap});

  @override
  State<AddNewButton> createState() => _AddNewButtonState();
}

class _AddNewButtonState extends State<AddNewButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
