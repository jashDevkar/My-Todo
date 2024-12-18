import 'package:flutter/material.dart';

const kHeaderTextStyle = TextStyle(
  fontSize: 52,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

const kTaskCountStyle=TextStyle(
  fontSize: 24,
  color: Colors.white
);


final  kInputFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  )
);

final kSubmitButtonStyle = ButtonStyle(
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0)
  ))
);

const kWhiteText = TextStyle(
  color: Colors.white
);

const kFiltertitleStyle = TextStyle(
  fontSize: 24.0
);

const kTodoTitleStyle=TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.black87
);

const kTododoDescriptionStyle = TextStyle(
  fontSize: 16
);

const kDateStyle = TextStyle(
  color: Colors.black54,
  fontSize: 11
);