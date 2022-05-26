import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart' ;
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 380,
          minWidth: 190,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(240),
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(120, name: TABLET),
            ResponsiveBreakpoint.autoScale(120, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      home: HomePage() ,
      );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30,color: Colors.white);

  final List<String> buttons =
  [
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','00','.','=',
  ];



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userQuestion, style: TextStyle(fontSize:  40,color: Colors.white),),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,style: TextStyle(fontSize:  40,color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){

                    if(index == 0 ||index ==  1 ||index ==  2){
                      if(index == 1){
                        return MyButton(
                          buttonTapped: () {
                            setState((){
                              userQuestion = userQuestion.substring(0,userQuestion.length-1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.grey,
                          textColor: Colors.black,
                        );
                      }
                      else if(index == 0){
                        return MyButton(
                          buttonTapped: () {
                            setState((){
                              userQuestion = "";
                              userAnswer = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.grey,
                          textColor: Colors.black,
                        );
                      }
                      else{
                        return MyButton(
                          buttonTapped: () {
                            setState((){
                              userQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.grey,
                          textColor: Colors.black,
                        );
                      }
                    }
                    else if(index > 2 && index < 19){
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index] ,
                        color: isOperator(buttons[index]) ? Colors.orange:Colors.white10,
                        textColor: isOperator(buttons[index]) ? Colors.white:Colors.white,
                        );
                      }
                    else if(index == 19){
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index] ,
                        color: isOperator(buttons[index]) ? Colors.orange:Colors.grey,
                        textColor: isOperator(buttons[index]) ? Colors.white:Colors.white,
                      );
                    }
                    else{
                      return MyButton(
                        buttonTapped: () {
                         setState(() {
                           userQuestion += buttons[index];
                          });
                       },
                       buttonText: buttons[index] ,
                       color: isOperator(buttons[index]) ? Colors.black54:Colors.black54,
                       textColor: isOperator(buttons[index]) ? Colors.black38:Colors.white,
                     );
                    }
                  }),
              ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if( x == '/' || x == '-' || x == '+' || x == '=' || x == 'x'){
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('%', '*0.01');
    finalQuestion = finalQuestion.replaceAll('+''-', '-');
    finalQuestion = finalQuestion.replaceAll('-''+', '-');
    finalQuestion = finalQuestion.replaceAll('-''-', '+');

    Parser p =Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
    userAnswer = eval.toStringAsFixed(8);
    userQuestion = '';
    if(userAnswer == "Infinity") {
      userAnswer = "error";
    }
    else if (userAnswer.substring(userAnswer.length - 1, userAnswer.length) == '0')
              {
                if (userAnswer.substring(userAnswer.length - 2, userAnswer.length - 1) == '0')
                {
                  if (userAnswer.substring(userAnswer.length - 3, userAnswer.length - 2) == '0')
                  {
                    if (userAnswer.substring(userAnswer.length - 4, userAnswer.length - 3) == '0')
                    {
                      if (userAnswer.substring(userAnswer.length - 5, userAnswer.length - 4) == '0')
                      {
                        if (userAnswer.substring(userAnswer.length - 6, userAnswer.length - 5) == '0')
                        {
                          if (userAnswer.substring(userAnswer.length - 7, userAnswer.length - 6) == '0')
                          {
                            if (userAnswer.substring(userAnswer.length - 8, userAnswer.length - 7) == '0')
                              {
                                 userAnswer = eval.toStringAsFixed(0);
                            }else {userAnswer = eval.toStringAsFixed(1);}
                           }else {userAnswer = eval.toStringAsFixed(2);}
                          }else {userAnswer = eval.toStringAsFixed(3);}
                         }else {userAnswer = eval.toStringAsFixed(4);}
                        }else {userAnswer = eval.toStringAsFixed(5);}
                       }else {userAnswer = eval.toStringAsFixed(6);}
                }else {userAnswer = eval.toStringAsFixed(7);}
               }
           }
     }
