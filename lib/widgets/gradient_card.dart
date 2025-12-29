import 'package:flutter/material.dart';
import 'package:mock_mart/constants/size_config.dart';

class GradientCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;

  const GradientCard({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title1, 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: SizeConfig.blockWidth * 4.5,
                  ),
                ),

                Text(
                  title2, 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: SizeConfig.blockWidth * 6, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Text(
                  title3, 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: SizeConfig.blockWidth * 6, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}