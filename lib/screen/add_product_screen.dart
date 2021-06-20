import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppylist/helper/database_helper.dart';
import 'package:shoppylist/model/color_palette.dart';
import 'package:shoppylist/model/item_model.dart';

class AddProductScreen extends StatefulWidget {

  final Item item;
  final Function updateProductList;

  AddProductScreen({this.updateProductList, this.item});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final _formKey = GlobalKey<FormState>();
  
  String _name = "";
  String _note = "";
  String _priority = "None";

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _name = widget.item.name;
      _note = widget.item.note;
      _priority = widget.item.priority;
    }
    
  }

  _delete() {

    DatabaseHelper.instance.deleteItem(widget.item.id);
    widget.updateProductList();
    Navigator.pop(context);
  }

  _submit() {

    if (_formKey.currentState.validate()) {

      _formKey.currentState.save();
      Item item = Item(name: _name, note: _note, priority: _priority);

      if (widget.item == null) {
        item.status = 0;
        DatabaseHelper.instance.insertItem(item);
      } else {

        item.id = widget.item.id;
        item.status = widget.item.status;
        DatabaseHelper.instance.updateItem(item);
      }

      widget.updateProductList();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 0),),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/icons/left-arrow.svg', width: 20, height: 20, color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    widget.item == null ? 'Add To List' : 'Update Item',
                    style: TextStyle(color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                          child: Container(
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                ),
                                onSaved: (input) => _name = input,
                                initialValue: _name,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: TextFormField(
                                autofocus: true,
                                maxLines: 10,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                  hintText: 'Notes',
                                  hintStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, decoration: TextDecoration.none),
                                  border: InputBorder.none,
                                ),
                                onSaved: (input) => _note = input,
                                initialValue: _note,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Notes greater than 20 characters will not appear in the list, but will remain saved when the single item is opend.',
                                  style: TextStyle(color: textSecondaryColor, fontSize: 12.0, height: 1.3, fontWeight: FontWeight.bold),
                                ),
                                widget.item == null ? SizedBox(height: 0.0) : SizedBox(height: 4.0),
                                Text(
                                  widget.item == null ? '' : "In this case, there're ${_note.length} characters.",
                                  style: TextStyle(color: primaryColor, fontSize: 12.0, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: _priority != 'Low' ? Colors.white : priorityLowColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            
                                          });

                                          if (_priority == 'Low')
                                            _priority = 'None';
                                          else
                                            _priority = 'Low';
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                            child: Text(
                                              'Low', style: TextStyle(color: _priority != 'Low' ? priorityLowColor : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: _priority != 'Medium' ? Colors.white : priorityMediumColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            
                                          });

                                          if (_priority == 'Medium')
                                            _priority = 'None';
                                          else
                                            _priority = 'Medium';
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                            child: Text(
                                              'Medium', style: TextStyle(color: _priority != 'Medium' ? priorityMediumColor : Colors.white,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: _priority != 'High' ? Colors.white : priorityHighColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            
                                          });

                                          if (_priority == 'High')
                                            _priority = 'None';
                                          else
                                            _priority = 'High';
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                            child: Text(
                                              'High', style: TextStyle(color: _priority != 'High' ? priorityHighColor : Colors.white,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: widget.item == null ? primaryColor : Colors.white,
                              boxShadow: [
                              BoxShadow(color: primaryColor.withOpacity(0.2), spreadRadius: 10, blurRadius: 20.0, offset: Offset(0, 0),),
                            ],
                            ),
                            child: InkWell(
                              onTap: () {
                                _submit();
                              },
                              child: Center(
                                child: Text(
                                  widget.item == null ? 'Add new Item' : 'Update Item',
                                  style: widget.item == null ? TextStyle(color: Colors.white, fontWeight: FontWeight.bold) 
                                                             : TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        widget.item != null ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () {
                              _delete();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 5.0),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: priorityLowColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ) : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}