// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medbox/api/medicineapi.dart';
import 'package:medbox/service/helper.dart';
import 'package:medbox/service/userservice.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: User.medicine == null || User.medicine!.length < 2
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF24CCCC),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                weight: 5,
                size: 32,
              ),
              onPressed: () {
                _showAddMedicineDialog(context);
              },
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView.builder(
          itemCount: User.medicine!.length,
          itemBuilder: (context, index) {
            final medicine = User.medicine![index];
            final List<String> doses = List<String>.from(medicine["time"]);
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
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 15,
                                runSpacing: 10,
                                children: doses.map((dose) {
                                  DateTime doseTime = DateTime.parse(dose);
                                  bool isNearest = doseTime ==
                                      findNearestTime(medicine["time"]);
                                  return Text(
                                    formatTime(doseTime),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: const Color(0xFF62F4F4),
                                      fontWeight: isNearest
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: isNearest ? 24 : 20,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            IconButton(
                              visualDensity:
                                  const VisualDensity(horizontal: -4),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this medicine?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            if (mounted) {
                                              setState(() {
                                                isDeleting = true;
                                              });
                                            }
                                            int response = await removeMedicine(
                                                medicine["_id"], context);
                                            if (response == 200) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Medicine Detail Deleted Successfully"),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                              if (mounted) {
                                                setState(() {
                                                  isDeleting = false;
                                                });
                                              }
                                            } else {
                                              if (mounted) {
                                                setState(() {
                                                  isDeleting = false;
                                                });
                                              }
                                            }
                                          },
                                          child: isDeleting
                                              ? const Text(
                                                  'Deleting...',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            IconButton(
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                onPressed: () {
                                  _showAddMedicineDialog(context,
                                      initialMedicineName: medicine["medName"],
                                      initialDosage: medicine["dosage"],
                                      medid: medicine["_id"],
                                      initialTime: medicine["time"]);
                                },
                                icon: const CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medicine["medName"],
                                      style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${medicine["dosage"]} Dose",
                                      style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  void _showAddMedicineDialog(BuildContext context,
      {String? initialMedicineName,
      int? initialDosage,
      String? medid,
      List<dynamic>? initialTime}) {
    bool addingMedicine = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          String medicineName = initialMedicineName ?? '';
          TextEditingController medicinenamecontroller =
              TextEditingController();
          medicinenamecontroller.text = initialMedicineName ?? "";
          int dosage = initialDosage ?? 0;
          List<TextEditingController> timeControllers = List.generate(
            dosage,
            (index) {
              DateTime initialDateTime =
                  initialTime != null && index < initialTime.length
                      ? DateTime.parse(initialTime[index])
                      : DateTime.now();

              TextEditingController controller = TextEditingController();
              controller.text = formatTime(initialDateTime);
              return controller;
            },
          );

          List<DateTime> times = initialTime
                  ?.map((timeString) => DateTime.parse(timeString))
                  .toList() ??
              [];
          List<dynamic> doseTime = initialTime ?? [];

          final formKey = GlobalKey<FormState>();
          List<GlobalKey<FormState>> formKey2 =
              List.generate(dosage, (index) => GlobalKey<FormState>());

          DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
            final now = DateTime.now();
            DateTime current = DateTime(
                now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

            return current;
          }

          return AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            actionsPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Text(
              medid == null ? 'Add Medicine' : 'Update Medicine',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  void add() {
                    setState(() {
                      if (dosage != 12) {
                        dosage++;
                        timeControllers.add(TextEditingController());
                        times.add(DateTime.now());
                        doseTime.add("");
                        formKey2.add(GlobalKey<FormState>());
                      }
                    });
                  }

                  void minus() {
                    setState(() {
                      if (dosage != 0) {
                        dosage--;
                        timeControllers.removeLast();
                        times.removeLast();
                        doseTime.removeLast();
                        formKey2.removeLast();
                      }
                    });
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: TextFormField(
                          onSaved: (value) {
                            medicineName = value!;
                          },
                          controller: medicinenamecontroller,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return ("Medicine Name is Mandatory");
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Medicine Name',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color(0xFF323232)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('Dosage: ',
                                style: TextStyle(fontSize: 16.0)),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: minus,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('$dosage',
                                style: const TextStyle(fontSize: 16.0)),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: add,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int i = 0; i < dosage; i++)
                        Form(
                          key: formKey2[i],
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return ("Time field can't be Null");
                                }
                                return null;
                              },
                              onTap: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (newTime != null) {
                                  setState(() {
                                    times[i] =
                                        convertTimeOfDayToDateTime(newTime);
                                    timeControllers[i].text =
                                        formatTime(times[i]);

                                    doseTime[i] = times[i].toIso8601String();
                                  });
                                }
                              },
                              controller: timeControllers[i],
                              decoration: InputDecoration(
                                labelText: 'Dose ${i + 1} Time',
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xFF323232)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    addingMedicine = true;
                  });
                  bool isValid = formKey.currentState!.validate();
                  if (!isValid) {
                    setState(() {
                      addingMedicine = false;
                    });
                    return;
                  } else {
                    if (dosage == 0) {
                      setState(() {
                        addingMedicine = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enter at least one doses"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    } else {
                      for (int i = 0; i < dosage; i++) {
                        bool isValid = formKey2[i].currentState!.validate();
                        if (!isValid) {
                          setState(() {
                            addingMedicine = false;
                          });
                          return;
                        }
                      }
                      formKey.currentState!.save();
                      final medicine = {
                        "medName": medicineName,
                        "dosage": dosage.toInt(),
                        "time": doseTime
                      };
                      if (medid == null) {
                        int result = await addMedicine(medicine, context);
                        if (result == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Medicine Detail Added Successfully"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          if (mounted) {
                            setState(() {
                              addingMedicine = false;
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      } else {
                        int result =
                            await updateMedicine(medid, medicine, context);
                        if (result == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Medicine Detail Updated Successfully"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          if (mounted) {
                            setState(() {
                              addingMedicine = false;
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      }
                    }
                  }
                },
                child: addingMedicine
                    ? Text(
                        medid == null
                            ? 'Adding............'
                            : "Updating........",
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      )
                    : Text(medid == null ? 'Add' : "Update"),
              ),
            ],
          );
        });
  }
}
