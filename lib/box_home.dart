import 'package:flutter/material.dart';

class HomeBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;

  HomeBox({
    Key? key,
    required this.smartDeviceName,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              Image.asset(
                iconPath,
                height: 65,
                color: Colors.white,
              ),

              // smart device name
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  smartDeviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // "Mainkan" button
              ElevatedButton(
                onPressed: () {
                  // Add your play button functionality here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set the button color
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                ),
                child: const Text(
                  "Play",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
