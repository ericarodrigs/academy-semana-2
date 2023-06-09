import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  //Defina essas propriedades para nossa classe 'Button'

  final Color? color;
  final Color textColor;
  final String buttonText;
  final Function()? buttontapped;

  //Faça aqui um construtor para receber via parametro
  // e popular nossas propriedade
  const Button(
      {Key? key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      this.buttontapped})
      : super(key: key);

  //Abaixo temos o comentario
  // indicando onde cada propriedade devera ir

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
