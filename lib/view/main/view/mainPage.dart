import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationWallController;

  @override
  void initState() {
    super.initState();
    animationWallController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        upperBound: 350,
        lowerBound: 0);
    animationController = AnimationController(
      vsync: this,
      lowerBound: 120,
      upperBound: 200,
      duration: const Duration(seconds: 2),
    );

    animationWallController.forward();

    animationWallController.addListener(() {
      debugPrint(animationWallController.value.toString());
      if (animationWallController.value > 160 &&
          animationWallController.value < 250 &&
          animationController.value > 0 &&
          animationController.value < 170) {
        debugPrint('YOU LOST DFJDKFJDKFJDKF');
        animationController.stop();
        animationWallController.stop();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Game over'),
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('You lost'),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              animationWallController.reset();
                              animationWallController.forward();
                              animationController.forward();
                              animationController.reset();
                            },
                            child: const Text('Try again'))
                      ],
                    )
                  ],
                ));
      }
      setState(() {});
    });

    animationController.addListener(() {
      // debugPrint('MARIO CANTROLLER >> ${animationController.value.toString()}');
      setState(() {});
    });

    animationWallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationWallController.repeat();
      }
      if (animationWallController.value.toInt() == 200) {
        debugPrint('TEGDI');
      }
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }

      if (animationWallController.value == animationController.value) {
        animationWallController.dispose();
      }
      // debugPrint/(status.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBlue,
      body: InkWell(
        onTap: () {
          animationController.forward();
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  color: CupertinoColors.systemBlue,
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: CupertinoColors.activeGreen,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: animationController.value,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset('assets/images/mario.gif'),
                  ),
                ),
                Positioned(
                    right: animationWallController.value,
                    bottom: 170,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Image.asset('assets/images/wall.jpeg'),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
