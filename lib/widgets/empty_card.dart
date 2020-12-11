import 'package:flutter/material.dart';
import 'package:credicxo_task/utils/theme..dart';

class EmptyCard extends StatelessWidget {
  final String type;
  EmptyCard({this.type=''});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin:
        EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        elevation: 15,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: primaryColor ,
                          style: BorderStyle.solid,
                          width: 4.0))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.hourglass_empty),
                    SizedBox(width: 5,),
                    Text(
                      " No $type to show",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )),
        ));

  }
}
