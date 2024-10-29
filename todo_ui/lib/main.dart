import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_ui/ToDoModel.dart';

void main() {
  runApp(const ToDoList());
}

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ToDoListUI());
  }
}

class ToDoListUI extends StatefulWidget {
  State createState() => _ToDoListUI();
}

class _ToDoListUI extends State {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Color> cardcolors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];
  List<ToDomodel> toDoCards = [
    ToDomodel(
        title: "Flutter",
        description:
            "Flutter is an open source framework for building beautiful, natively compiled, multi-platform applications.",
        date: "18 Oct 2024"),
  ];

  List<String> listImg = [
    "assets/img2.png",
  ];

  void submit(bool doEdit, [ToDomodel? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (doEdit) {
        obj!.title = titleController.text;
        obj.description = descriptionController.text;
        obj.date = dateController.text;
      } else {
        toDoCards.add(ToDomodel(
            title: titleController.text,
            description: descriptionController.text,
            date: dateController.text));
      }
    }

    Navigator.of(context).pop();
    clearControllers();
    setState(() {});
  } //submit

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void bottomSheet(bool doEdit, [ToDomodel? obj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 10.0,
                left: 12.0,
                right: 12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Create ToDo",
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.black)),
                      ),
                    )
                  ],
                ),
                Text(
                  "Title",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(0, 139, 148, 1.0))),
                ),
                TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 139, 148, 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Description",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(0, 139, 148, 1.0))),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 139, 148, 1.0)))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Date",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(0, 139, 148, 1.0))),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 139, 148, 1.0))),
                      suffixIcon: const Icon(Icons.calendar_month_outlined)),
                  onTap: () async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2026));
                    String formatDate = DateFormat.yMMMMd().format(
                        pickDate!); //For this intl package required pls import
                    setState(() {
                      dateController.text = formatDate;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (doEdit == true) {
                        submit(true, obj);
                      } else {
                        submit(false);
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(0, 139, 148, 1))),
                    child: Text("Submit",
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white))))
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "To-do List",
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
        body: ListView.builder(
            itemCount: toDoCards.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Container(
                      width: 400,
                      height: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: cardcolors[index % cardcolors.length],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 52,
                                    height: 52,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                            "assets/Group 42 (1).svg"))),
                              ),
                              const SizedBox(width: 29),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          toDoCards[index].title,
                                          style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12)),
                                        )),
                                    Text(
                                      toDoCards[index].description,
                                      style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                toDoCards[index].date,
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10)),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      titleController.text =
                                          toDoCards[index].title;
                                      descriptionController.text =
                                          toDoCards[index].description;
                                      dateController.text =
                                          toDoCards[index].date;
                                      bottomSheet(true, toDoCards[index]);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color.fromRGBO(2, 167, 177, 1),
                                    ),
                                  ), //EDIT
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      toDoCards.remove(toDoCards[index]);
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.delete_outline,
                                        color: Color.fromRGBO(2, 167, 177, 1)),
                                  ), //DELETE
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              bottomSheet(false);
              setState(() {});
            },
            backgroundColor: const Color.fromRGBO(0, 139, 144, 1),
            child: const Icon(Icons.add, color: Colors.white)));
  }
}
