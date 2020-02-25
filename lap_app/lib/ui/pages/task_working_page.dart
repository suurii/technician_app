import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_app/data/entities/entities.dart';
import 'package:lap_app/ui/widget/widgets.dart';
import 'package:meta/meta.dart';

class TaskWorkingPage extends StatelessWidget {
  final TokenCredential tokenCredential;

  const TaskWorkingPage({Key key, 
    @required this.tokenCredential,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Network Configuration',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: TabBar(
                  indicatorColor: const Color(0xff36B772),
                  labelColor: Color(0xff69736D),
                  tabs: [
                    new Tab(
                      text: 'DETAIL',
                    ),
                    new Tab(text: 'EQUIPMENT')
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                // Text('Detail na ja')
                buildBodyDetail(context),
                // Text('Device na ja')
                buildBodyDevice(context)
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    RaisedButton(
                    color: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      side: BorderSide(color: const Color(0xFF36B772))
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      confirmDialog(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          'จบการทำงาน',
                          style: TextStyle(
                              fontFamily: 'supermarket', fontSize: 20, color: const Color(0xFF46B085)),
                        )),
                  ),
                RaisedButton(
                    color: const Color(0xFF2FDC96),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      confirmDialog(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          'Console >',
                          style: TextStyle(
                              fontFamily: 'supermarket', fontSize: 20),
                        )),
                  )

                  ],
                )

              )
        )
      );
  }

  void confirmDialog(BuildContext context){
    var cfDialog = AlertDialog(
      title: Text("ยืนยันการรับทำงาน"),
      content: Text("ชื่องาน/โปรเจคที่จะรับนะจ้ะ pass ค่ามาให้ด้วย"),
      actions: <Widget>[
        OutlineButton(
          child: Text("ยกเลิก"),
          onPressed: (){
            Navigator.pop(context);
         },),
        OutlineButton(
          child: Text("ยืนยัน"),
          onPressed: (){
            print('Yeah ok you got this job by API and going to next page');
            // Navigator.pop(context);
          },)

      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return cfDialog;
      }
    );

  }
}