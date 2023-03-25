import 'package:flutter/material.dart';
import 'package:meat_gradation_app/widgets/all_buttons.dart';

// ignore: must_be_immutable
class OptionSheet extends StatelessWidget {
  String heading, leftButtonMessage, rightButtonMessage;
  Function leftButtonFunction, rightButtonFunction;
  Color leftButtonColor, rightButtonColor;

  OptionSheet(
      {Key? key,
      required this.heading,
      required this.leftButtonMessage,
      required this.rightButtonMessage,
      required this.leftButtonFunction,
      required this.rightButtonFunction,
      required this.leftButtonColor,
      required this.rightButtonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              spreadRadius: 0.5,
              offset: Offset(0.7, 0.7),
            )
          ]),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 22, fontFamily: 'Brand-Bold', color: Colors.black87),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: BigButton(
                    title: leftButtonMessage,
                    fontColor: Colors.white,
                    backgroundColor: leftButtonColor,
                    onPressed: () {
                      leftButtonFunction();
                    }),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: BigButton(
                    title: rightButtonMessage,
                    fontColor: Colors.white,
                    backgroundColor: rightButtonColor,
                    onPressed: () {
                      rightButtonFunction();
                    }),
              )
            ],
          )
        ]),
      ),
    );
  }
}
