import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lap_app/bloc/bloc.dart';
import 'package:lap_app/data/entities/entities.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:lap_app/ui/widget/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
  Widget buildBodyDevice(BuildContext contex){
      final List<String> entries = <String>['A', 'B', 'C'];
      final List<int> colorCodes = <int>[600, 500, 100];

      List<String> nameDevice = <String>['SWITCH1','SWITCH1','SWITCH1'];
      List<String> modelDevice = <String>['123','456','789'];
      List<String> typeDevice = <String>['Switch','Lab','Multimeter'];

      return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: nameDevice.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // height: 50,
                  // color: Colors.amber[colorCodes[index]],
                  child: Row(
                    
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.all(16),
                        height: 78.0,
                        width: 78.0,
                        child:ImageDisplay(imageName: 'aislogo.png'),
               
                      ),

                      Expanded(
                        
                        child: Column(
                          children: <Widget>[
                            Align(alignment: Alignment.centerLeft,child:  Text('${nameDevice[index]}',style: TextStyle(fontFamily: 'supermarket',fontSize: 18),)),
                            Container(margin: EdgeInsets.only(top: 6),),
                            Align(alignment: Alignment.centerLeft,child:  Text('รุ่นอุปกรณ์ : ${modelDevice[index]} ',style: TextStyle(fontFamily: 'supermarket',fontSize: 18)),),
                            Container(margin: EdgeInsets.only(top: 6),),
                            Align(alignment: Alignment.centerLeft,child:  Text('TYPE : ${typeDevice[index]}',style: TextStyle(fontFamily: 'supermarket',fontSize: 18)),),
                          ],
                          
                        ),

                      ),

                     ButtonTheme(
                        minWidth: 44,
                        height:44,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                              side: BorderSide(color: Color.fromARGB(255, 54, 183, 114))),
                          color: Color(0xFAFAFA),
                          textColor: Color.fromARGB(255, 54, 183, 114),
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {},
                          child: Icon(Icons.arrow_forward, color: Color.fromARGB(255, 54, 183, 114))
                      ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right:MediaQuery.of(context).size.width* 0.047)
                      )
                      
                    ],
                  )

                  // Center(child: Text('Entry ${entries[index]}'))
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
  }