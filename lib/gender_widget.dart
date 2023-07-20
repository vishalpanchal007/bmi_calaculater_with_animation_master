import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key, required this.onChange});
  final Function(int) onChange;
  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  int gender = 0;
  final ChoiceChip3DStyle selectedStyle = ChoiceChip3DStyle(
      topColor: Colors.grey[200]!,
      backColor: Colors.grey,
      borderRadius: BorderRadius.circular(20));
  final ChoiceChip3DStyle unselectedStyle = ChoiceChip3DStyle(
      topColor: Colors.white,
      backColor: Colors.grey[300]!,
      borderRadius: BorderRadius.circular(20));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip3D(
            border: Border.all(color: Colors.grey),
            style: gender == 1 ? selectedStyle : unselectedStyle,
            onSelected: () {
              setState(() {
                gender = 1;
              });
              widget.onChange(gender);
            },
            onUnSelected: () {},
            selected: gender == 1,
            child: Column(
              children: [
                Image.asset(
                  'assets/male.png',
                  width: 50,
                ),
                SizedBox(height: 5),
                Text('Male')
              ],
            ),
          ),
          SizedBox(width: 20),
          ChoiceChip3D(
            border: Border.all(color: Colors.grey),
            style: gender == 2 ? selectedStyle : unselectedStyle,
            onUnSelected: () {},
            onSelected: () {
              setState(() {
                gender = 2;
              });
              widget.onChange(gender);
            },
            selected: gender == 2,
            child: Column(
              children: [
                Image.asset(
                  'assets/female.png',
                  width: 50,
                ),
                SizedBox(height: 5),
                Text('Female')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
