import 'package:flutter/material.dart';

import '../controllers/text_controller.dart';
import 'constants.dart';

class MyBottum extends StatelessWidget {
  const MyBottum({
    Key? key,
    required this.width,
    required this.height,
    required this.textController,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final TextController textController;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child : Container(
        width: width*.5,
        height:height*.05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF92A3BF),
                Color(0xFF495260),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5,
                offset: Offset(0,5),
              )
            ]
        ),
        child:  Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sign IN',
              style: TextStyle(
                fontSize:textController.getSize('TITLE'),
                color:kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}