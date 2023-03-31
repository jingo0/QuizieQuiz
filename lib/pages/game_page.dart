import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiziequiz/providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  late double? _deviceHeight, _deviceWidth;
  final String difficultyLevel;

  GamePageProvider? _pageProvider;

  GamePage(
    {required this.difficultyLevel}
    );
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, difficultyLevel: difficultyLevel,), 
      child:_buildUI()
      );
  }

  Widget _buildUI() {
    return Builder(
      builder: (context) {
        _pageProvider = context.watch<GamePageProvider>();
        if( _pageProvider!.questions != null)
        {
          return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceHeight! * 0.05,
              ),
              child: _gameUI(),
            ),
          ),
        );
      }
      else{
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
        }
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _deviceHeight!*0.01,),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuetionText(),
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerToCurrQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceHeight! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerToCurrQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceHeight! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
