import 'dart:math';

import 'package:arbiter_examinator/presentation/screens/login_screen.dart';
import 'package:arbiter_examinator/presentation/screens/resultScreen.dart';
import 'package:arbiter_examinator/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, String> selectedAnswers = {};
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color.fromARGB(255, 190, 227, 225),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextWidget(
                    text: "birnimabek birnimajonov",
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          title: SlideCountdown(
            duration: Duration(minutes: 2),
            separator: ":",
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            separatorStyle: TextStyle(
              color: Colors.blue,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            onDone: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Resultscreen(),
                  ));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: screenWidth >= 600
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: buildQuestionList(),
                    ),
                    Flexible(
                      flex: 1,
                      child: buildGrid(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: buildQuestionList(),
                    ),
                    Flexible(
                      flex: 1,
                      child: buildGrid(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildQuestionList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Container(
        color: Colors.white.withOpacity(0.2),
        child: ListView.builder(
          controller: scrollController,
          itemCount: 50,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, bottom: 5),
                    child: TextWidget(
                      text: "${index + 1}-savol ",
                      fontSize: 14.sp,
                      maxLines: 10,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  key: ValueKey(index),
                  children: [
                    answerTileWidget(index, 'A'),
                    answerTileWidget(index, 'B'),
                    answerTileWidget(index, 'C'),
                    answerTileWidget(index, 'D'),
                  ],
                ),
                const Divider(thickness: 1),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget answerTileWidget(int questionIndex, String variant) {
    bool isSelected = selectedAnswers[questionIndex] == variant;

    return ListTile(
      hoverColor: Colors.blueAccent.withOpacity(0.3),
      onTap: () {
        setState(() {
          selectedAnswers[questionIndex] = variant;
        });
      },
      mouseCursor: MouseCursor.defer,
      leading: CircleAvatar(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        child: TextWidget(
          text: variant,
          fontSize: 14.sp,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      title: Text(
        "javoblar  ",
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.blue.shade100 : Colors.transparent,
    );
  }

  Widget buildGrid() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 50,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    scrollToQuestion(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: selectedAnswers.containsKey(index)
                                ? const Color.fromARGB(255, 4, 47, 97)
                                : const Color.fromARGB(255, 108, 169, 200),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: Center(
                            child: Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.r),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resultscreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                enabledMouseCursor: MouseCursor.defer,
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              ),
              child: TextWidget(
                text: "Yakunlash",
                fontSize: 16.sp,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  void scrollToQuestion(int questionIndex) {
    double offset = questionIndex * 260.h;
    scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
