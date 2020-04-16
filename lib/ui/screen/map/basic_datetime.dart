import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTimePage extends StatefulWidget {
  @override
  MyDateTimePageState createState() => MyDateTimePageState();
}

class MyDateTimePageState extends State<MyDateTimePage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        //appBar: AppBar(title: Text("select datetime")),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            DateTimeForm(),
          ],
        ));
        
  }
}

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey1,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[      
          SizedBox(height: 20),
          BasicDateTimeField(),          
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[   
           SizedBox(height: 20), 
          RaisedButton(
            child: Text('Save'),
            onPressed: () => formKey1.currentState.save(),
          ),
          RaisedButton(
            child: Text('Reset'),
            onPressed: () => formKey1.currentState.reset(),
          ),
          RaisedButton(
            child: Text('Validate'),
            onPressed: () => formKey1.currentState.validate(),
          ),
         ]
      ),
      ]),    
    );


  }
}
class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('select pickup datetime'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2022));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}