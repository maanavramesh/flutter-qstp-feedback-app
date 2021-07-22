import 'package:flutter/material.dart';

String result = "";
var labelColor = Colors.redAccent[700], resultColor;
List<int> ratings = [];
double rating = 1;
int i = 0, total = 0;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
  routes: <String, WidgetBuilder>{'/ResultPage': (context) => ResultPage()},
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> questionsList = [
    "How do you like our service?",
    "How do you appreciate the sanitization?",
    "How was the sound quality?",
    "How was the lighting?",
    "How likely are you to recommend us to your friends?",
    "How likely are you to come back here?"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Feedback App"),
          centerTitle: true,
        ),
        body: Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                questionsList.elementAt(i),
                style: TextStyle(fontSize: 25, color: Colors.teal[800]),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16,15,15,16),
                    child: Text(
                      "${rating.toInt()}",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: Slider.adaptive(
                        value: rating,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: labelColor,
                        label: "${rating.toInt()}",
                        onChanged: (newRating) {
                          setState(() {
                            rating = newRating;
                            switch (rating.toInt()) {
                              case 1:
                                labelColor = Colors.redAccent[700];
                                break;
                              case 2:
                                labelColor = Colors.orangeAccent[400];
                                break;
                              case 3:
                                labelColor = Colors.amberAccent[400];
                                break;
                              case 4:
                                labelColor = Colors.lightGreen[800];
                                break;
                              case 5:
                                labelColor = Colors.lightGreenAccent[400];
                                break;
                            }
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ratings.add(rating.toInt());
                    if (i < 5) {
                      i++;
                      labelColor = Colors.redAccent[700];
                      total += rating.toInt();
                      rating = 1;
                    } else {
                      total += rating.toInt();
                      if (total < 11) {
                        result = "We are sorry for your inconvenience";
                        resultColor = Colors.redAccent[700];
                      } else if (total < 21) {
                        result = "Hope we serve you better next time";
                        resultColor = Colors.amberAccent[400];
                      } else {
                        result = "We hope you come back next time.";
                        resultColor = Colors.lightGreenAccent[400];
                      }
                      Navigator.pushNamed(context, '/ResultPage');
                      setState(() {
                        i = 0;
                        rating = 1;
                        total = 0;
                        labelColor = Colors.redAccent[700];
                        ratings.removeRange(0, 5);
                      });
                    }
                  });
                },
                child: Text("Next"),
              ),
            ])));
  }
}

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merci"),
        centerTitle: true,
        leading: SizedBox(width: 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$result",
              style: TextStyle(
                  color: resultColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                },
              child:Text(
                "Restart",
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 18,
                    ),
              ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              )
            )
          ],
        ),
      ),
    );
  }
}

