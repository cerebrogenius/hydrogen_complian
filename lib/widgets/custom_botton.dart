import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final IconData icon;
  final Color color;
  final Function()? onTap;
  const CustomButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      this.onTap,  required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: color),
      child: GestureDetector(
        onTap: onTap,
        child: isLoading==false? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: const TextStyle(color: Colors.white)),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ): FittedBox(
          child: Container(
            constraints:const BoxConstraints(maxHeight: 50,maxWidth: 50),
            child:const AspectRatio(
              aspectRatio: 1/1,
              child:  CircularProgressIndicator(color: Colors.white,)),
          ),
        )
      ),
    );
  }
}
