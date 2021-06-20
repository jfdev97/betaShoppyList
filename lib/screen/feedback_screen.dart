import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppylist/model/color_palette.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackScreen extends StatefulWidget {

  FeedbackScreen({this.app});
  final FirebaseApp app;

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final referenceDatabase = FirebaseDatabase.instance;

  String _stringProblem = "Select a problem";
  String _firstProblem = "Problems creating an item";
  String _secondProblem = "Problems updating an item";
  String _threeProblem = "Problems deleting an item";
  int contButton = 0;

  String _noteProblem = "Tell us how can we improve, what would you like to have inside the app";

  bool _pressedButton = false;
  bool _dropdownMenuActive = false;
  bool _problemActive = false;

  final myController = TextEditingController();

  Widget _submitButton() {

    final ref = referenceDatabase.reference();

    return InkWell(
      onTap: () {

        final strProblem = _stringProblem;

        setState(() {
          if (!_pressedButton) {
            _pressedButton = true; 
            contButton = 1;
          }
        });



        if (_pressedButton == true && contButton == 1) {
          ref
            .child('feedback')
            .push()
            .child('tipo')
            .set(myController.text)
            .asStream();

            contButton++;
        }
      },
      child: Ink(
        child: AnimatedContainer(
          width: _pressedButton ? 60 : MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: _pressedButton ? BorderRadius.circular(50) : BorderRadius.circular(8.0),
            border: _pressedButton ? Border.all(color: Colors.transparent, width: 2) : Border.all(color: primaryColor, width: 2),
            color: _pressedButton ? primaryColor : Colors.white,
          ),
          duration: const Duration(milliseconds: 300),
          child: Center(
            child: _pressedButton ? SvgPicture.asset('assets/icons/check.svg', width: 20, height: 20, color: Colors.white) : Text(
              _pressedButton ? '' : 'Submit', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/icons/close.svg', width: 20, height: 20, color: primaryColor),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: SvgPicture.asset('assets/icons/feedback_image.svg', width: 150, height: 150),
                    ),
                    SizedBox(height: 40.0),
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _dropdownMenuActive = !_dropdownMenuActive;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _dropdownMenuActive ? Border.all(color: primaryColor, width: 3) : Border.all(color: Colors.transparent),
                                boxShadow: [
                                  BoxShadow(
                                    color: _dropdownMenuActive ? primaryColor.withOpacity(0.4) : Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3, 
                                    blurRadius: 20,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(_stringProblem, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Icon(Icons.arrow_drop_down, size: 30.0, color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                          child: Visibility(
                            visible: _dropdownMenuActive ? true : false,
                            maintainSize: false,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {

                                          if (_stringProblem == 'Select a problem') {
                                            _stringProblem = _firstProblem;
                                            _problemActive = true;
                                          } else {
                                            _stringProblem = 'Select a problem';
                                            _problemActive = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _problemActive && _stringProblem == _firstProblem ? primaryColor.withOpacity(0.8) : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              _firstProblem,
                                              style: TextStyle(
                                                color: _problemActive && _stringProblem == _firstProblem ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold, 
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_stringProblem == 'Select a problem') {
                                            _stringProblem = _secondProblem;
                                            _problemActive = true;
                                          } else {
                                            _stringProblem = 'Select a problem';
                                            _problemActive = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _problemActive && _stringProblem == _secondProblem ? primaryColor.withOpacity(0.8) : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              _secondProblem,
                                              style: TextStyle(
                                                color: _problemActive && _stringProblem == _secondProblem ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold, 
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_stringProblem == 'Select a problem') {
                                            _stringProblem = _threeProblem;
                                            _problemActive = true;
                                          } else {
                                            _stringProblem = 'Select a problem';
                                            _problemActive = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _problemActive && _stringProblem == _threeProblem ? primaryColor.withOpacity(0.8) : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              _threeProblem,
                                              style: TextStyle(
                                                color: _problemActive && _stringProblem == _threeProblem ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold, 
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          child: Visibility(
                            visible: !_dropdownMenuActive ? true : false,
                            maintainSize: false,
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 20,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              height: 170,
                              child: TextFormField(
                                controller: myController,
                                autofocus: false,
                                maxLines: 10,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                  hintText: _noteProblem,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 70.0),
                      child: Center(
                        child: _submitButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}