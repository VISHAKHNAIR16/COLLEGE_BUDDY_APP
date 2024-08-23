import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:microit_app/appbar/curveappbar.dart';
import 'package:microit_app/model/faculty_model.dart';
import 'package:microit_app/widget/faculty_card.dart';
import 'package:flutter/cupertino.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() {
    return _FacultyScreenState();
  }
}

class _FacultyScreenState extends State<FacultyScreen> {
  List<FacultyModel> facultyList = [];
  List<FacultyModel> filteredFacultyList = [];
  final TextEditingController _textController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFacultyData();
  }

  Future<void> fetchFacultyData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('faculty').get();
      final List<FacultyModel> loadedFaculty = snapshot.docs.map((doc) {
        return FacultyModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      setState(() {
        facultyList = loadedFaculty;
        filteredFacultyList = loadedFaculty;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchFaculty(String query) {
    final suggestions = facultyList.where((faculty) {
      final facultyName = faculty.name.toLowerCase();
      final input = query.toLowerCase();
      return facultyName.contains(input);
    }).toList();

    setState(() {
      filteredFacultyList = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: ClipPath(
          clipper: Curveappbar(),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/design.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 26, 96, 66),
                        width: 3.5,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Faculty Info",
                    style: TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(201, 0, 0, 0),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: CupertinoSearchTextField(
                    controller: _textController,
                    onChanged: searchFaculty,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: filteredFacultyList.length,
                    itemBuilder: (ctx, index) {
                      return FacultyCard(faculty: filteredFacultyList[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
