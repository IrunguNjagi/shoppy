import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool outlineBtn;
  final bool isLoading;

  CustomBtn({required this.text, required this.onPressed, required this.outlineBtn,required this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _outlineBtn ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: _isLoading,
                child: SizedBox(
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}