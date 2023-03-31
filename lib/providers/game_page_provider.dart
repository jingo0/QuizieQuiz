import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier{
  final Dio _dio = Dio();
  final int _maxQuestions = 10;

  List? questions;
  int _currentQuestionCount = 0;
  int _totalScore = 0;

  BuildContext context;

  GamePageProvider({required this.context, required String difficultyLevel}){
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuetionsFromApi(difficultyLevel);
  }

  Future<void> _getQuetionsFromApi(String difficultyLevel) async{
    var res = await _dio.get(
    '', 
    queryParameters: {'amount':_maxQuestions , 'difficulty': difficultyLevel, 'type': 'boolean'});

    var _data = jsonDecode(res.toString());
    questions = _data['results'];
    notifyListeners();
  }

  String getCurrentQuetionText()
  {
    return "${_currentQuestionCount+1}. ${questions![_currentQuestionCount]['question']}";
  }

  Future<void> answerToCurrQuestion(String ans)
  async {
    bool isCorrect = questions![_currentQuestionCount]['correct_answer'] == ans;
    _currentQuestionCount+=1;
    if(isCorrect) _totalScore++;
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      }
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if(_currentQuestionCount == _maxQuestions){
      endGame();
    }
    else{
      notifyListeners();
    }
  }

  Future<void> endGame() async
  {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          content: Text(
            "Score: $_totalScore/$_maxQuestions",
            style: const TextStyle(fontSize: 25, color: Colors.amber),
          ),
        );
      }
    );

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
    _currentQuestionCount=0;
    _totalScore=0;
  }
}