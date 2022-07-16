import 'package:flutter/material.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';

//Como visto na aula de quinta-feira, temos abaixo o código que faz a estrutura de uma calculadora,
// o desafia para essa semana é utilizar nosso componente customizado "button" de algumas formas,
// da forma que o código está no momento, nossos valores já estão aparecendo no display,
// e o botão de "=" já está com a funcionalidade implementada,
// você deve implementar as funcionalidades de "Limpar" no nosso botão "C",
// e esta funcionalidade devera resetar os valores dos nossos atributos "userInput" e de "answer",
// e a funcionalidade de "Deletar" no nosso botão "DEL",
// e esta funcionalidade devera remover o ultimo digito de nosso "userInput",
// lembrando que devemos executar estas operação como alteração de estado,
// então é usado a chamada do nosso metodo "setState".

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

//A classe HomePage é a classe que faz o desenho da nossa calculadora,
// e a classe MyApp é a classe que faz o desenho da nossa tela principal.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Nosso atributo "userInput" é um string que armazena o valor que está sendo digitado pelo usuário.
  String userInput = '';
  //Nosso atributo "answer" é um string que armazena o valor que está sendo mostrado na tela como resposta.
  String answer = '';

  //Lista de botões da calculadora
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculador'),
      ),
      backgroundColor: Colors.white38,
      //Esta Column é onde começa o desenho da nossa calculadora,
      body: Column(
        children: <Widget>[
          //Este Expanded é onde fica o display da nossa calculadora,
          Expanded(
              //Este Container é onde fica o que é digitado pelo usuário,
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                //Já este Container é onde fica o que é mostrado na tela como resposta,
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
          //Este Expanded é onde fica a lista de botões da calculadora,
          Expanded(
            flex: 3,
            child: Container(
              //Aqui utilizamos o GridView.builder para criar uma lista de widget botões,
              child: GridView.builder(
                //Aqui utilizamos o itemCount para definir o número de botões que serão criados,
                itemCount: buttons.length,
                //Aqui utilizamos o gridDelegate para definir o tamanho dos botões,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                //Aqui utilizamos o itemBuilder para criar os botões,
                itemBuilder: (BuildContext context, int index) {
                  //Clear Button
                  if(buttons[index] == 'C'){
                    return Button(
                    buttontapped: () {
                      setState(() {
                        clearAll();
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.grey[400],
                  textColor: Colors.black,
                  );
                }
                  // //Delete Button
                  if(buttons[index] == 'DEL'){
                    return Button(
                      buttontapped: () {
                        setState(() {
                          deleteLastDigit();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey[400],
                      textColor: Colors.black,
                    );
                  }
                  //Equal_to Button
                  if (buttons[index] == '=') {
                    return Button(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[500],
                      textColor: Colors.white,
                    );
                  }
                  //Especial buttons
                  if (buttons[index] == '+/-' || buttons[index] == '%'){
                    return Button(
                        buttontapped: () =>
                        setState(() => userInput += buttons[index]),
                        color: Colors.grey[400],
                        textColor: Colors.black,
                        buttonText: buttons[index]);
                  }
                  //other buttons
                  else {
                    return Button(
                        buttontapped: () =>
                            setState(() => userInput += buttons[index]),
                        color: isOperator(buttons[index])
                            ? Colors.blue[300]
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                        buttonText: buttons[index]);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

//Método que verifica se o botão que foi pressionado é um operador.
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

//Método que converte a String do usuário em uma expressão matemática e calcula o resultado.
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    //Aqui utilizamos o parseExpression para converter a String do usuário em uma expressão matemática.
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    //Aqui utilizamos o evaluate para calcular o resultado da expressão matemática.
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    //Aqui convertemos o resultado em String e atribuimos ao atributo "answer".
    answer = eval.toString();
  }

  void clearAll() {
    userInput = '';
    answer = '';
  }

  void deleteLastDigit() {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, (userInput.length - 1));
    }
  }
}

