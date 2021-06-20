import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppylist/helper/database_helper.dart';
import 'package:shoppylist/model/color_palette.dart';
import 'package:shoppylist/model/item_model.dart';
import 'package:shoppylist/screen/add_product_screen.dart';
import 'package:shoppylist/screen/feedback_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Item>> _itemList;

  String _priorityActive = 'All';
  int contPressButton = 0; 

  _selectColor(String valuePriority) {

    Color risColor;

    switch(valuePriority) {
      case 'Low': 
        risColor = priorityLowColor;
        break;
      case 'Medium': 
        risColor = priorityMediumColor;
        break;
      case 'High': 
        risColor = priorityHighColor;
        break; 
      default: 
        risColor = Colors.black;
    }

    return risColor;
  }

  /** 
    void feedbackScreenShow() {

      contPressButton++;

      if (contPressButton >= 3 && contPressButton < 4) 
        Navigator.push(context, MaterialPageRoute(builder: (_) => FeedbackScreen()));

      if (contPressButton > 4) {
        contPressButton = 0;
      }
    }
  */

  Widget _buildButtonPriorityListView() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _priorityActive = 'All';
                });
              },
              child: Container(
                width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _priorityActive == 'All' ? primaryColor : backgroundScreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'All',
                    style: TextStyle(color: _priorityActive == 'All' ? Colors.white : primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_priorityActive == 'All')
                    _priorityActive = 'None';
                  else
                    _priorityActive = 'All';
                });
              },
              child: Container(
                width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _priorityActive == 'None' ? primaryColor : backgroundScreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'None',
                    style: TextStyle(color: _priorityActive == 'None' ? Colors.white : primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_priorityActive == 'Low')
                    _priorityActive = 'All';
                  else
                    _priorityActive = 'Low';
                });
              },
              child: Container(
                width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _priorityActive == 'Low' ? priorityLowColor : backgroundScreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Low',
                    style: TextStyle(color: _priorityActive == 'Low' ? Colors.white : priorityLowColor, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_priorityActive == 'Medium')
                    _priorityActive = 'All';
                  else
                    _priorityActive = 'Medium';
                });
              },
              child: Container(
                width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _priorityActive == 'Medium' ? priorityMediumColor : backgroundScreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Medium',
                    style: TextStyle(color: _priorityActive == 'Medium' ? Colors.white : priorityMediumColor, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_priorityActive == 'High')
                    _priorityActive = 'All';
                  else
                    _priorityActive = 'High';
                });
              },
              child: Container(
                width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _priorityActive == 'High' ? priorityHighColor : backgroundScreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'High',
                    style: TextStyle(color: _priorityActive == 'High' ? Colors.white : priorityHighColor, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _updateItemList();
  }

  void _updateItemList() {
    setState(() {
      _itemList = DatabaseHelper.instance.getItemList();
    });
  }

  Widget _buildItem(Item item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Visibility(
        visible: _priorityActive == 'None' && item.priority == 'None'
                                           || _priorityActive == 'All' 
                                           || _priorityActive == 'Low' && item.priority == 'Low'
                                           || _priorityActive == 'Medium' && item.priority == 'Medium'
                                           || _priorityActive == 'High' && item.priority == 'High' ? true : false,
        maintainSize: false,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: item.note.length == 0 && item.priority == 'None' ? Container (
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 80.0,
                  child: Center(
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: item.status == 1 ? primaryColor : backgroundScreenColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GestureDetector(
                        
                        onTap: () {
                          setState(() {
                            if (item.status == 1)
                              item.status = 0; 
                            else
                              item.status = 1; 
                          });  

                          DatabaseHelper.instance.updateItem(item);
                          _updateItemList();
                        },
                        child: item.status == 1 ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/icons/check.svg', width: 20.0, height: 20.0, color: Colors.white),
                        ) : Text(''),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductScreen(updateProductList: _updateItemList, item: item),),),
                    child: Container(
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: item.status == 1 ? primaryColor : backgroundScreenColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                color: item.status == 1 ? Colors.white : Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ): Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 80.0,
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: item.status == 1 ? primaryColor : backgroundScreenColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (item.status == 1) 
                              item.status = 0;
                            else
                              item.status = 1;
                            
                            DatabaseHelper.instance.updateItem(item);
                            _updateItemList();
                          });
                        },
                        child: item.status == 1 ? Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/icons/check.svg', width: 20.0, height: 20.0, color: Colors.white,),
                        ): Text(''),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductScreen(updateProductList: _updateItemList, item: item),),),
                    child: Container(
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: item.status == 1 ? primaryColor : backgroundScreenColor,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 5.0),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                color: item.status == 1 ? Colors.white : Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Visibility(
                            maintainSize: false,
                            visible: item.note == "" ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 15.0, bottom: 10.0),
                              child: Text(
                                item.note.length > 33 ? '' : item.note,
                                style: TextStyle(
                                  color: item.status == 1 ? Colors.white : Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: item.priority == 'None' ? EdgeInsets.only(right: 0) : EdgeInsets.only(top: 5.0, left: 15.0, bottom: 10.0),
                            child: item.priority == 'None' ? Text('') : Text(
                              item.priority,
                              style: TextStyle(
                                color: item.status == 0 ? _selectColor(item.priority) : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder(
          future: _itemList,
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: primaryColor,),
              );
            }

            final int completedItemCount = snapshot.data
            .where((Item item) => item.status == 1)
            .toList()
            .length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {

                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Welcome in',
                              style: TextStyle(fontWeight: FontWeight.bold, color: textSecondaryColor, fontSize: 16),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              'Your ShoppyList',
                              style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              child: Text(
                                '$completedItemCount of ${snapshot.data.length}',
                                style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 20.0),
                        child: _buildButtonPriorityListView(),
                      ),
                    ],
                  );
                }
                return _buildItem(snapshot.data[index - 1]);
              },
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          child: Icon(Icons.add, size: 50.0,),
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddProductScreen(updateProductList: _updateItemList,))
            );
          },
        ),
      ),
    );
  }
}