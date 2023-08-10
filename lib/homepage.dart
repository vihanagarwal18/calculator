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
  String selectedExpressionFormat = "INFIX";

  void _showSettingsPopupMenu(BuildContext context) async {
    final String? selectedOption = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust the position as needed
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'INFIX',
          child: Text(
              'INFIX',
              style: TextStyle(
                //color: darkmode ? colorLight :colorDark,
                //backgroundColor: darkmode ? colorDark :colorLight,
              ),
          ),
          onTap: (){
            setState(() {
              selectedExpressionFormat="Infix";
            });
          },
        ),
        PopupMenuItem<String>(
          value: 'PREFIX',
          child: Text('PREFIX'),
          onTap: (){
            setState(() {
              selectedExpressionFormat="Prefix";
            });
          },
        ),
        PopupMenuItem<String>(
          value: 'POSTFIX',
          child: Text('POSTFIX'),
          onTap: (){
            setState(() {
              selectedExpressionFormat="Postfix";
            });
          },
        ),
      ],
    );

    if (selectedOption != null) {
      // Handle the selected option here
      // For example, you can call a method to update the expression format
      // based on the selectedOption ('INFIX', 'PREFIX', 'POSTFIX')
      // updateExpressionFormat(selectedOption);
    }
  }


  bool darkmode=false;
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
              height: h/2.79,
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
                color: darkmode ? Colors.white54 :userInputColor,
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
                color: darkmode ? Colors.white54 :userInputColor,
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
    
    if(selectedExpressionFormat=="PREFIX"){
      evaluating_String=prefixToInfix(userInput);
      print(evaluating_String);
    }

    if(selectedExpressionFormat=="POSTFIX"){
      evaluating_String=postfixToInfix(userInput);
      print(evaluating_String);
    }
    try{
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

  // String calculate(){
  //   try{
  //     var exp= Parser().parse(userInput);
  //     var eveluation=exp.evaluate(EvaluationType.REAL,ContextModel());
  //     setState(() {
  //       userInputColor=darkmode? Colors.white54 :Colors.black;
  //     });
  //     return eveluation.toString();
  //   }
  //   catch(e){
  //     setState(() {
  //       userInputColor=darkmode? Colors.greenAccent :Colors.redAccent;
  //     });
  //     return "Error";
  //     //return temp_input;
  //   }
  // }

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
  // prefixToInfix(String prefixExpression) {
  //   // Your conversion logic here
  // }
  postfixToInfix(String postfixExpression) {
    // Your conversion logic here
  }

}
