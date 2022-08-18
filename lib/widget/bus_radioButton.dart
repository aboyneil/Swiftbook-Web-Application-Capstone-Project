import 'package:admin/globals.dart';
import 'package:flutter/material.dart';

class RadioButtonGroupWidget extends StatefulWidget {
  @override
  _RadioButtonGroupWidgetState createState() => _RadioButtonGroupWidgetState();
}

class _RadioButtonGroupWidgetState extends State<RadioButtonGroupWidget> {
  static const values = <String>['Active', 'Inactive'];
  String selectedValue = values.first;

  final selectedColor = Colors.green;
  final unselectedColor = Colors.white;

  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRadios(),
            ],
          ),
        ),
      );

  Widget buildRadios() => Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: unselectedColor,
        ),
        child: Column(
          children: values.map(
            (value) {
              if (busStatus == false){
                selectedValue = values.last;
              }else if (busStatus == true ){
                selectedValue = values.first;
              }

              final selected = this.selectedValue == value;
              final color = selected ? selectedColor : unselectedColor;

              return RadioListTile<String>(
                value: value,
                groupValue: selectedValue,

                title: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white70),
                ),
                activeColor: selectedColor,
                onChanged: (value) {
                  setState((){
                    this.selectedValue = value;
                    if (value == 'Inactive'){
                      busStatus = false;
                      tripStatus = false;
                    }else{
                      busStatus = true;
                      tripStatus = true;
                    }

                  });
                },

              );
            },
          ).toList(),
        ),
      );
}
