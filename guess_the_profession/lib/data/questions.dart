import 'package:flutter/material.dart';
import 'package:guess_the_profession/models/question.dart';

ValueNotifier<List<Question>> easyQuestions = ValueNotifier([
  Question("DOCTOR", "assets/images/easy_pack/doctor/stethoscope.jpg"),
  Question("STUDENT", "assets/images/easy_pack/student/pencil.jpg"),
  Question("CARPENTER", "assets/images/easy_pack/carpenter/pincers.jpg"),
  Question("DOCTOR", "assets/images/easy_pack/doctor/stethoscope.jpg"),
  Question("STUDENT", "assets/images/easy_pack/student/pencil.jpg"),
  Question("CARPENTER", "assets/images/easy_pack/carpenter/pincers.jpg"),
  Question("DOCTOR", "assets/images/easy_pack/doctor/stethoscope.jpg"),
  Question("STUDENT", "assets/images/easy_pack/student/pencil.jpg"),
  Question("CARPENTER", "assets/images/easy_pack/carpenter/pincers.jpg"),
]);

List<Question> mediumQuestions = [
  Question("DOCTOR", "assets/images/easy_pack/doctor/stethoscope.jpg"),
  Question("STUDENT", "assets/images/easy_pack/student/pencil.jpg"),
  Question("CARPENTER", "assets/images/easy_pack/carpenter/pincers.jpg")
];

List<Question> hardQuestions = [
  Question("DOCTOR", "assets/images/easy_pack/doctor/stethoscope.jpg"),
  Question("STUDENT", "assets/images/easy_pack/student/pencil.jpg"),
  Question("CARPENTER", "assets/images/easy_pack/carpenter/pincers.jpg")
];
