import 'dart:math';
import 'package:bmi_calaculater_with_animation_master/age_widget.dart';
import 'package:bmi_calaculater_with_animation_master/scorescreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'gender_widget.dart';
import 'height_widget.dart';
import 'model.dart';

enum Gender { male, female }

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  double value = 0;
  Gender? selectedGender;
  int height = 150;
  int weight = 50;
  int age = 50;
  double bmiScore = 0;
  int gender = 0;
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  mainColor,
                  Color(0xffadaadf),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: 200,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Jack Patel',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Person',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          title: Text(
                            'BMI History',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Settings',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 5000),
              curve: Curves.easeIn,
              builder: (_, double val, __) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: mainColor,
                        title: Text('BMI Calculator'),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(),
                            child: Column(
                              children: [
                                GenderWidget(
                                  onChange: (genderVal) {
                                    gender = genderVal;
                                  },
                                ),
                                HeightWidget(onChange: (heightVal) {
                                  height = heightVal;
                                }),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 10),
                                    AgeWeightWidget(
                                      onChange: (ageVal) {
                                        age = ageVal;
                                      },
                                      title: 'Age',
                                      initValue: 30,
                                      max: 100,
                                      min: 0,
                                    ),
                                    AgeWeightWidget(
                                      onChange: (weightVal) {
                                        weight = weightVal;
                                      },
                                      title: 'Weight(Kg)',
                                      initValue: 50,
                                      min: 0,
                                      max: 200,
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ScoreScreen(
                                            bmiScore: bmiScore,
                                            age: age,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        isFinished = false;
                                      });
                                      calculateBmi();
                                    },
                                    onDoubleTap: () {
                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() {
                                          isFinished = true;
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 300,
                                      child: Center(
                                        child: Text(
                                          'Calculate',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }

  void calculateBmi() {
    bmiScore = weight / pow(height / 100, 2);
  }
}
