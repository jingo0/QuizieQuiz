import 'package:flutter/material.dart';
import 'package:quiziequiz/pages/game_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  late double? _deviceHeight, _deviceWidth;
  double _currentDifficultyLvl = 0;
  final List<String> _difficultyLevel = ['Easy', 'Medium', 'Hard'];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appTitle(),
                _slider(),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle()
  {
    return Column(
      children: [
        const Text("QuizieQuiz", 
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(_difficultyLevel[_currentDifficultyLvl.toInt()], 
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _slider()
  {
    return Slider(
      label: 'Difficulty',
      min: 0,
      max: 2,
      divisions: 2,
      value: _currentDifficultyLvl, 
      onChanged: (value){
        setState(() {
          _currentDifficultyLvl=value;
        });
      }
    );
  }

  Widget _startButton()
  {
    return MaterialButton(
      onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)
          {
            return GamePage(
              difficultyLevel: _difficultyLevel[_currentDifficultyLvl.toInt()].toLowerCase(),
              );
          }
          )
        );
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10 ,
      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
      ),
    );
  }

}
