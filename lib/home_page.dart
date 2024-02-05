import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'box_home.dart';
import 'tetris_game/tetris_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ Tittle, Icon, Router ]
    ["Chess", "icons/chess.png", null],
    [
      "Tetris",
      "icons/tetris.png",
      const GameBoard(),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 45),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text "Welcome"
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home,",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        'Raf!',
                        style: GoogleFonts.bebasNeue(fontSize: 72),
                      ),
                    ],
                  ),

                  // Spacer between text and image
                  const SizedBox(width: 45),

                  // Image Icon
                  Image.asset(
                    'icons/home.png',
                    height: 120,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            // smart devices grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Your Game..",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // grid
            Expanded(
              child: GridView.builder(
                itemCount: 2,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return HomeBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    onTap: () {
                      // Navigasi ke halaman yang sesuai saat item ditekan yaitu tetris
                      if (mySmartDevices[index][2] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => mySmartDevices[index][2],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
