import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JokePage(),
    );
  }
}
class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  String question = "Press the button to get a Joke";
  String answerjoke = "";
bool showanswer = false;

  void loadJoke()async{

    const url = "https://official-joke-api.appspot.com/random_joke";

 final response = await http.get(Uri.parse(url));

if (response.statusCode == 200){
  final data = json.decode(response.body);
  setState(() {
    question = "${data['setup']}";
    answerjoke =" ${data['punchline']}";
    showanswer =false;
  });
}else {
  setState(() {
    question = "Error loading joke";
    answerjoke= "";
    showanswer = false;

  });
}
}
  void showAnswerjoke(){
    setState(() {
      showanswer=true;
    });
//ui
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text('Joke API'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
  padding: EdgeInsets.all(10),
  child:Text(
      question,
textAlign: TextAlign.center,
     style: TextStyle(fontSize: 20,)

  ),
      ),
if(showanswer)
      Padding(
        padding: EdgeInsets.all(10),
        child:Text(
            answerjoke,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,)
        ),
      ),


      const SizedBox(height: 20),
ElevatedButton(onPressed: loadJoke, child: Text("Question")),

      const SizedBox(height: 20),
      ElevatedButton(onPressed: showAnswerjoke, child: Text("Answer"))

    ],
  ),
),
    );

  }
}
