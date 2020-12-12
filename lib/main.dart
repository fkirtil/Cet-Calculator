import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cet Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyCalculator (),
    );
  }
}


class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}


class _MyCalculatorState extends State<MyCalculator> {


  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }


      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }


      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;


        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);


          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }


      }


      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }


  Widget buildButton(String buttonText, double buttonHeight, double buttonWidth, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.1 * buttonWidth,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cet Calculator')),
      body: Column(
        children: <Widget>[




          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,
                        style: TextStyle(
                            fontSize: equationFontSize,
                            fontFamily: 'Texturina',
                        ),
            ),
          ),




          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,
                        style: TextStyle(
                            fontSize: resultFontSize,
                            fontFamily: 'Texturina',
                        ),
                  ),
          ),




          Expanded(
            child: Divider(
              indent: 30,
              endIndent: 30,
              thickness: 2,
              color: Colors.indigo,
            ),
          ),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              width: MediaQuery.of(context).size.width,
                child: Table(
                  columnWidths: {0: FlexColumnWidth(2)},
              children: [
              TableRow(
                      children: [
                            buildButton("C", 1, 2, Colors.redAccent),
                            buildButton("⌫", 1, 1, Colors.blue),
                            buildButton("÷", 1, 1, Colors.blue),
                                  ]

                              ),
                          ],
                        ),
                  ),
          ],
    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              buildButton("7", 1, 1, Colors.black54),
                              buildButton("8", 1, 1, Colors.black54),
                              buildButton("9", 1, 1, Colors.black54),
                              buildButton("×", 1, 1, Colors.blue),
                            ]
                        ),


                        TableRow(
                            children: [
                              buildButton("4", 1, 1, Colors.black54),
                              buildButton("5", 1, 1, Colors.black54),
                              buildButton("6", 1, 1, Colors.black54),
                              buildButton("+", 1, 1, Colors.blue),
                            ]
                        ),


                        TableRow(
                            children: [
                              buildButton("1", 1, 1, Colors.black54),
                              buildButton("2", 1, 1, Colors.black54),
                              buildButton("3", 1, 1, Colors.black54),
                              buildButton("-", 1, 1, Colors.blue),
                            ]
                        ),


                        TableRow(
                            children: [
                              buildButton(".", 1, 1, Colors.black54),
                              buildButton("0", 1, 1, Colors.black54),
                              buildButton("00", 1, 1, Colors.black54),
                              buildButton("=", 1, 1, Colors.blue),
                            ]
                        ),
                      ],
                    ),
                  ),

                ],
              ),


            ],
          ),
        );
      }
    }
