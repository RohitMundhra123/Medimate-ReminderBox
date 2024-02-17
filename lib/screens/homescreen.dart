import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medbox/service/helper.dart';
import 'package:medbox/service/userservice.dart';
import 'package:medbox/widgets/clock/clockscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Good Morning",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          User.name!.replaceAllMapped(RegExp(r'\b\w'),
                              (match) => match.group(0)!.toUpperCase()),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white60,
                      child: User.gender == "M"
                          ? SvgPicture.asset(
                              "assets/icons/male.svg",
                              height: 48,
                            )
                          : SvgPicture.asset(
                              "assets/icons/female.svg",
                              height: 46,
                            ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.white60,
                  height: 15,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: ClockScreen(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: User.medicine!.length,
                itemBuilder: (context, index) {
                  final medicine = User.medicine![index];
                  final dosage = medicine["dosage"];
                  final doseTimes = List<DateTime>.from(
                    medicine["time"].map((time) => DateTime.parse(time)),
                  );

                  // Sort the dose times based on their proximity to the current time (future times only)
                  doseTimes.sort(
                    (a, b) => a.isAfter(DateTime.now())
                        ? a
                            .difference(DateTime.now())
                            .compareTo(b.difference(DateTime.now()))
                        : 1,
                  );

                  List<Widget> doseWidgets = List.generate(dosage, (doseIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C1320),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white24,
                              offset: Offset(5, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Colors.white30,
                              offset: Offset(-1, -1),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(doseTimes[doseIndex]),
                                    style: const TextStyle(
                                      color: Color(0xFF62F4F4),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/pill.svg",
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            medicine["medName"],
                                            style: const TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Dose ${doseIndex + 1}",
                                            style: const TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });

                  return Column(
                    children: doseWidgets,
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
