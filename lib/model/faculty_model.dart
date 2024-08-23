class FacultyModel {
  const FacultyModel({
    required this.name,
    required this.cabin,
    required this.school,
    required this.image,
    required this.title,
  });

  final String name;
  final String cabin;
  final String school;
  final String image;
  final String title;

  factory FacultyModel.fromMap(Map<String, dynamic> data) {
    return FacultyModel(
      name: data['name'],
      cabin: data['cabin'],
      school: data['school'],
      image: data['image'],
      title: data['title'],
    );
  }
}
