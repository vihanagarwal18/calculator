import 'package:flutter/material.dart';
//import 'package:calculator/NeuContainer.dart';
import 'package:flutter/rendering.dart';
//import 'package:calculator/calculator_logic.dart';
//import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';
//import 'package:infix_expression_parser/infix_expression_converter.dart';
// ignore_for_file: prefer_const_constructors

const Color colorDark=Color(0xFF374352);
const Color colorLight=Color(0xFFe6eeff);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  //String selectedcalculator="INFIX";
  bool isValidExpression = true;
  String selectedExpressionFormat = "Infix";

  void _showSettingsPopupMenu(BuildContext context) async {
    final String? selectedOption = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Infix',
          child: Text('Infix'),
          onTap: () {
            setState(() {
              selectedExpressionFormat = "Infix";
              result="0";
              userInput="";
            });
          },
        ),
        PopupMenuItem<String>(
          value: 'Prefix',
          child: Text('Prefix'),
          onTap: () {
            setState(() {
              selectedExpressionFormat="Prefix";
              result="0";
              userInput="";
              //Navigator.of(context).pop();
              //showInstructionsDialog();
            });
            //Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 200), () {
              showInstructionsDialog();
            });
          },
        ),
        PopupMenuItem<String>(
          value: 'Postfix',
          child: Text('Postfix'),
          onTap: () {
            setState(() {
              selectedExpressionFormat="Postfix";
              result="0";
              userInput="";
              //Navigator.of(context).pop();
              //showInstructionsDialog();
            });
            //Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 200), () {
              showInstructionsDialog();
            });

          },
        ),
      ],
    );
  }

  Future showInstructionsDialog() =>showDialog(
      context: context,
        builder:(context) => AlertDialog(
          title: Text("Instructions"),
          backgroundColor: darkmode ? colorLight :colorDark,
          content: Text(
              "Instructions for input format:\n1. Enter single-digit numbers only.\n2. Operators should be directly adjacent to operands.\n3. Do not use parentheses. \n4. If input isn't in correct format answer would be displayed 0 .\n5. Here is an example of Prefix expression : +*53/82 and whose Infix expression is ((5*3)+(8/2)) \n6. Here is an example of Postfix expression :53*82/+ and whose Infix expression is ((5*3)+(8/2))",
              style: TextStyle(
                color: darkmode ? colorDark : colorLight,
              ),
          ),
          actions: [
            TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      },
                      child: Text("OK")
                  ),
               ],
        )
  );

  bool darkmode=true;
  String result="0";
  String userInput="";
  late String temp_input;
  Color userInputColor = Colors.black54;
  List<String> buttonList=["AC","(",")","/","7","8","9","*","4","5","6","+","1","2","3","-","C","0",".","="];
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${selectedExpressionFormat} Calulator" ,
            style: TextStyle(
              color: darkmode ? colorLight :colorDark,
            ),
          ),
          backgroundColor: darkmode? colorDark :colorLight,
          actions: [
            //one for postfix infix expression
            IconButton(
                icon: Icon(
                    Icons.settings,
                    color: darkmode? colorLight :colorDark,
                ),
                onPressed:(){
                  //settingdialogbox();
                  _showSettingsPopupMenu(context);
                },
            ),
            IconButton(
              icon: Icon(
                  Icons.color_lens,
                  color: darkmode? colorLight :colorDark,
              ),
              onPressed: (){
                //switch boolean value of darkmode
                setState(() {
                  darkmode = !darkmode;
                });
              },
            )
            //one for color switch
          ],
        ),
        body: Column(
          children: [
            Container(
              height: h/3.00,
              child: resultWidget(),
            ),
            Expanded(
              child: buttonWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget(){
    return Container(
      color: darkmode ? colorDark :colorLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: TextStyle(
                fontSize: 32,
                color: darkmode ? colorLight:colorDark,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: userInputColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(){
    return Container(
      padding: EdgeInsets.all(10),
      color: darkmode? Color(0xFF1E2530):Color.fromARGB(66, 233, 232, 232),
      child: GridView.builder(
          itemCount:buttonList.length,
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder:(context,index){
            return button(buttonList[index]);
          }
      ),
    );
  }
  getColor(String text){
    if(text =="/" ||text =="*" || text=="+" || text=="-" || text=="C" || text=="(" || text==")"){
      return (darkmode? Colors.greenAccent: Colors.redAccent);
    }
    if(text=="=" || text=="AC"){
      return (darkmode? colorDark :colorLight);
    }
    return (darkmode? Colors.lightBlueAccent:Colors.indigo);
  }

  getBgColor(String text){
    if(text=="AC"){
      return (darkmode? Colors.greenAccent:Colors.redAccent);
    }
    if(text=="="){
      return (darkmode? Colors.greenAccent:Colors.redAccent);
    }
  }




  Widget button(String text){
    return InkWell(
      onTap: (){
        setState(() {
          handleButtonPress(text);
        });

      },
      child: Container(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: darkmode? Colors.black12.withOpacity(0.8): Colors.grey.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: getColor(text),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      ),
    );
  }
  handleButtonPress(String text){
    if(text =="AC"){
      userInput="";
      result="0";
      return;
    }
    if(text=="C"){
      if(userInput.length>0){
        userInput=userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }
    if(text=="="){
      setState(() {
        temp_input=userInput;
      });
      result =calculate();
      //userInput=result;
      if(userInput.endsWith(".0")){
        userInput=userInput.replaceAll(".0", "");//sarei .0 ko hata dega
      }
      if(result.endsWith(".0")){
        result=result.replaceAll(".0", "");//sarei .0 ko hata dega
      }
      return;
    }
    userInput=userInput+text;
  }
  String calculate(){
    String evaluating_String=userInput;

    if(selectedExpressionFormat=="Prefix"){
      String s=prefixToInfix(userInput);
      evaluating_String=s;
      print("Converted infix: $evaluating_String");
    }

    if(selectedExpressionFormat=="Postfix"){
      evaluating_String=postfixToInfix(userInput);
      print("Converted infix: $evaluating_String");
    }
    try{
      print("calculating\n");
      var exp= Parser().parse(evaluating_String);
      var eveluation=exp.evaluate(EvaluationType.REAL,ContextModel());
      setState(() {
        userInputColor=darkmode? Colors.white54 :Colors.black;
      });
      return eveluation.toString();
    }
    catch(e){
      setState(() {
        userInputColor=darkmode? Colors.greenAccent :Colors.redAccent;
      });
      return "Error";
      //return temp_input;
    }

  }

  bool isOperator(String symbol) {
    return symbol == "*" || symbol == "+" || symbol == "-" || symbol == "/" || symbol == "^" || symbol == "(" || symbol == ")";
  }
  String prefixToInfix(String prefix) {
    List<String> symbols = [];
    int l = prefix.length - 1;
    while (l >= 0) {
      if (!isOperator(prefix[l])) {
        symbols.add(prefix[l]);
        l--;
      } else {
        String string =
            "(${symbols.removeLast()}${prefix[l]}${symbols.removeLast()})";
        symbols.add(string);
        l--;
      }
    }
    return symbols.removeLast();
  }

  String postfixToInfix(String postfix) {
    List<String> symbols = [];
    for (int i = 0; i < postfix.length; i++) {
      if (!isOperator(postfix[i])) {
        symbols.add(postfix[i]);
      } else {
        String operand2 = symbols.removeLast();
        String operand1 = symbols.removeLast();
        String string = "($operand1${postfix[i]}$operand2)";
        symbols.add(string);
      }
    }
    return symbols.isEmpty ? "" : symbols.removeLast();
  }
}

//"Instructions for input format:\n1. Enter single-digit numbers only.\n2. Operators should be directly adjacent to operands.\n3. Do not use parentheses."