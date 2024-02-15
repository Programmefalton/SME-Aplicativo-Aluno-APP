import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final List<Widget> content;
  final IconData? icon;

  const InfoBox({super.key, required this.content, this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(screenHeight * 2),
            margin: EdgeInsets.only(
              top: screenHeight * 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffFFC6C8),
              ),
              borderRadius: BorderRadius.circular(screenHeight * 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
          Visibility(
            visible: icon != null,
            child: Positioned(
              top: screenHeight * 2.5,
              right: screenHeight * 2.5,
              child: Container(
                width: screenHeight * 5,
                height: screenHeight * 5,
                color: const Color(0xffffffff),
                child: Icon(
                  icon,
                  size: screenHeight * 2.3,
                  color: const Color(0xff666666),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
