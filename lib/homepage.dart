import 'package:flutter/material.dart';
import 'package:calculator/NeuContainer.dart';
import 'package:flutter/rendering.dart';
import 'package:calculator/calculator_logic.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore_for_file: prefer_const_constructors

const Color colorDark=Color(0xFF374352);
const Color colorLight=Color(0xFFe6eeff);


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      color: colorLight,
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
                color: userInputColor,
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
      color: Color.fromARGB(66, 233, 232, 232),
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
      return Colors.redAccent;
    }
    if(text=="=" || text=="AC"){
      return colorLight;
    }
    return Colors.indigo;
  }

  getBgColor(String text){
    if(text=="AC"){
      return Colors.redAccent;
    }
    if(text=="="){
      return colorLight;
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
              color: Colors.grey.withOpacity(0.1),
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
    try{
      var exp= Parser().parse(userInput);
      var eveluation=exp.evaluate(EvaluationType.REAL,ContextModel());
      setState(() {
        userInputColor=Colors.black;
      });
      return eveluation.toString();
    }
    catch(e){
      setState(() {
        userInputColor=Colors.redAccent;
      });
      return "Error";
      //return temp_input;
    }
  }
}

//
// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
// class _HomepageState extends State<Homepage> {
//   bool darkMode = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CalculatorLogic>(
//       create: (_) => CalculatorLogic(),
//       child: Consumer<CalculatorLogic>(
//         builder: (context, calculator, _) {
//           return Scaffold(
//             backgroundColor: darkMode ? colorDark : colorLight,
//             body: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 darkMode ? darkMode = false : darkMode = true;
//                               });
//                             },
//                             child: _switchMode(),
//                           ),
//                           SizedBox(height: 80),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               calculator.expression,
//                               style: TextStyle(
//                                 fontSize: 55,
//                                 fontWeight: FontWeight.bold,
//                                 color: darkMode ? Colors.white : Colors.red,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '=',
//                                 style: TextStyle(
//                                     fontSize: 35,
//                                     color: darkMode ? Colors.green : Colors.grey),
//                               ),
//                               Text(
//                                 '10+500*12',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: darkMode ? Colors.green : Colors.grey),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       child: Column(children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonOval(title: 'sin'),
//                             _buttonOval(title: 'cos'),
//                             _buttonOval(title: 'tan'),
//                             _buttonOval(title: '%')
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonRounded(
//                                 title: 'C',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent),
//                             _buttonRounded(title: '('),
//                             _buttonRounded(title: ')'),
//                             _buttonRounded(
//                                 title: '/',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonRounded(title: '7'),
//                             _buttonRounded(title: '8'),
//                             _buttonRounded(title: '9'),
//                             _buttonRounded(
//                                 title: 'x',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonRounded(title: '4'),
//                             _buttonRounded(title: '5'),
//                             _buttonRounded(title: '6'),
//                             _buttonRounded(
//                                 title: '-',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonRounded(title: '1'),
//                             _buttonRounded(title: '2'),
//                             _buttonRounded(title: '3'),
//                             _buttonRounded(
//                                 title: '+',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buttonRounded(title: '0'),
//                             _buttonRounded(title: ','),
//                             _buttonRounded(
//                                 icon: Icons.backspace_outlined,
//                                 iconColor:
//                                 darkMode ? Colors.green : Colors.redAccent),
//                             _buttonRounded(
//                                 title: '=',
//                                 textColor:
//                                 darkMode ? Colors.green : Colors.redAccent)
//                           ],
//                         )
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buttonRounded({
//     String? title,
//     double padding = 17,
//     IconData? icon,
//     Color? iconColor,
//     Color? textColor,
//   }) {
//     return Consumer<CalculatorLogic>(
//       builder: (context, calculator, _) {
//         return Padding(
//           padding: const EdgeInsets.all(8),
//           child: NeuContainer(
//             darkMode: darkMode,
//             borderRadius: BorderRadius.circular(40),
//             padding: EdgeInsets.all(padding),
//             child: GestureDetector(
//             onTap: () {
//           if (title == 'C') {
//           calculator.clearExpression();
//           } else if (title == '=') {
//           calculator.evaluateExpression();
//           } else {
//           calculator.addToExpression(title!);
//           }
//           },
//             child: Container(
//               width: padding * 2,
//               height: padding * 2,
//               child: Center(
//                 child: title != null
//                     ? Text(
//                   '$title',
//                   style: TextStyle(
//                     color: textColor != null
//                         ? textColor
//                         : darkMode ? Colors.white : Colors.black,
//                     fontSize: 30,
//                   ),
//                 )
//                     : Icon(
//                   icon,
//                   color: iconColor,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         );
//       },
//     );
//   }
//
//   Widget _buttonOval({String? title, double padding = 17}) {
//     return Consumer<CalculatorLogic>(
//       builder: (context, calculator, _) {
//         return Padding(
//           padding: const EdgeInsets.all(10),
//           child: NeuContainer(
//             darkMode: darkMode,
//             borderRadius: BorderRadius.circular(50),
//             padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
//             child: Container(
//               width: padding * 2,
//               child: Center(
//                 child: Text(
//                   '$title',
//                   style: TextStyle(
//                     color: darkMode ? Colors.white : Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _switchMode() {
//     return NeuContainer(
//       darkMode: darkMode,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       borderRadius: BorderRadius.circular(40),
//       child: Container(
//         width: 70,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(
//               Icons.wb_sunny,
//               color: darkMode ? Colors.grey : Colors.redAccent,
//             ),
//             Icon(
//               Icons.nightlight_round,
//               color: darkMode ? Colors.green : Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends State<Homepage> {
//   bool darkMode=false;
//   //final CalculatorLogic calculatorLogic = CalculatorLogic();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: darkMode ? colorDark : colorLight,
//       body: SafeArea(//SafeArea is a widget that insets its child with sufficient padding to avoid obstacles.
//                      // basically nodge ke neeche aa jayega safeArea main
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             darkMode ? darkMode = false : darkMode = true;
//                           });
//                         },
//                         child: _switchMode()),
//                     SizedBox(height: 80),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         '6.010',
//                         style: TextStyle(
//                             fontSize: 55,
//                             fontWeight: FontWeight.bold,
//                             color: darkMode ? Colors.white : Colors.red),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '=',
//                           style: TextStyle(
//                               fontSize: 35,
//                               color: darkMode ? Colors.green : Colors.grey),
//                         ),
//                         Text(
//                           '10+500*12',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: darkMode ? Colors.green : Colors.grey),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Column(children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonOval(title: 'sin'),
//                       _buttonOval(title: 'cos'),
//                       _buttonOval(title: 'tan'),
//                       _buttonOval(title: '%')
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonRounded(
//                           title: 'C',
//                           textColor:
//                           darkMode ? Colors.green : Colors.redAccent),
//                       _buttonRounded(title: '('),
//                       _buttonRounded(title: ')'),
//                       _buttonRounded(
//                           title: '/',
//                           textColor: darkMode ? Colors.green : Colors.redAccent)
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonRounded(title: '7'),
//                       _buttonRounded(title: '8'),
//                       _buttonRounded(title: '9'),
//                       _buttonRounded(
//                           title: 'x',
//                           textColor: darkMode ? Colors.green : Colors.redAccent)
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonRounded(title: '4'),
//                       _buttonRounded(title: '5'),
//                       _buttonRounded(title: '6'),
//                       _buttonRounded(
//                           title: '-',
//                           textColor: darkMode ? Colors.green : Colors.redAccent)
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonRounded(title: '1'),
//                       _buttonRounded(title: '2'),
//                       _buttonRounded(title: '3'),
//                       _buttonRounded(
//                           title: '+',
//                           textColor: darkMode ? Colors.green : Colors.redAccent)
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buttonRounded(title: '0'),
//                       _buttonRounded(title: ','),
//                       _buttonRounded(
//                           icon: Icons.backspace_outlined,
//                           iconColor:
//                           darkMode ? Colors.green : Colors.redAccent),
//                       _buttonRounded(
//                           title: '=',
//                           textColor: darkMode ? Colors.green : Colors.redAccent)
//                     ],
//                   )
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buttonRounded(
//       {String? title,
//       double padding = 17,
//       IconData? icon,
//       Color? iconColor,
//       Color? textColor}) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: NeuContainer(
//         darkMode: darkMode,
//         borderRadius: BorderRadius.circular(40),
//         padding: EdgeInsets.all(padding),
//         child: Container(
//           width: padding * 2,
//           height: padding * 2,
//           child: Center(
//               child: title != null
//                   ? Text(
//                       '$title',
//                       style: TextStyle(
//                           color: textColor != null
//                               ? textColor
//                               : darkMode
//                                   ? Colors.white
//                                   : Colors.black,
//                           fontSize: 30),
//                     )
//                   : Icon(
//                       icon,
//                       color: iconColor,
//                       size: 30,
//                     )),
//         ),
//       ),
//     );
//   }
//   Widget _buttonOval({String? title, double padding = 17}) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: NeuContainer(
//         darkMode: darkMode,
//         borderRadius: BorderRadius.circular(50),
//         padding:
//         EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
//         child: Container(
//           width: padding * 2,
//           child: Center(
//             child: Text(
//               '$title',
//               style: TextStyle(
//                   color: darkMode ? Colors.white : Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _switchMode() {
//     return NeuContainer(
//       darkMode: darkMode,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       borderRadius: BorderRadius.circular(40),
//       child: Container(
//         width: 70,
//         child:
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Icon(
//             Icons.wb_sunny,
//             color: darkMode ? Colors.grey : Colors.redAccent,
//           ),
//           Icon(
//             Icons.nightlight_round,
//             color: darkMode ? Colors.green : Colors.grey,
//           ),
//         ]),
//       ),
//     );
//   }
// }