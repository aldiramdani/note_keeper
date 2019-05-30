import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['High','Low'];
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      
      body: Padding(
          padding: EdgeInsets.only(top:15.0,left: 10.0,right: 10.0),
          child: ListView(
          children: <Widget>[

            ListTile(
              title: DropdownButton(

                  items: _priorities.map((String dropDownStringItem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  style: textStyle,
                  value: 'Low',


                  onChanged: (valueSelectedByUser){
                    setState(() {
                      debugPrint('User Selected $valueSelectedByUser');
                    });
                  }),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: TextField(
                controller: tittleController,
                style: textStyle,
                onChanged: (value){
                  debugPrint('something changed in title text field');
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),
            //3rd element
            Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value){
                  debugPrint('something changed in description text field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child:
                    RaisedButton(
                         color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                        ),
                    onPressed:(){
                    setState(() {
                      debugPrint('save button clicked');
                      });
                      },
                    ),
                    ),
                    //second element row
                    Container(width: 5.0,),
                    Expanded(child:
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed:(){
                        setState(() {
                          debugPrint('Delete button clicked');
                        });
                      },
                    ),
                    ),

                  ],
                ),
            )

      ],
      ) ,
      ),

    );
  }
}
