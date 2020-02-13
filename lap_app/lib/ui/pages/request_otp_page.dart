import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lap_app/bloc/bloc.dart';
import 'package:lap_app/data/entities/entities.dart';
import 'package:lap_app/ui/pages/pages.dart';
import 'package:lap_app/ui/widget/widgets.dart';
import 'package:uuid/uuid.dart';

class RequestOtpPage extends StatelessWidget {
  const RequestOtpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestOtpBloc(),
      child: RequestOtpPageChild(),
    );
  }
}

class RequestOtpPageChild extends StatelessWidget {
  TextEditingController txtController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<RequestOtpBloc, RequestOtpState>(
          listener: (context, state) {
            if (state is RequestOtpError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: state.color,
              ));
            } else if (state is RequestOtpSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<RequestOtpBloc>(context),
                    child: VerifyOtpPage(otpCredential: state.otpCredential)),
              ));
            }
          },
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.17, 
              top: MediaQuery.of(context).size.width* 0.5,
              right:  MediaQuery.of(context).size.width* 0.1),
              child: ImageDisplay(imageName: 'aislogo.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.width* 0.17),
            ),
            BlocBuilder(
              
              bloc: BlocProvider.of<RequestOtpBloc>(context),
              builder: (BuildContext context, state) {
                if (state is RequestOtpInitial) {
                  return buildBodyChild(context);
                } else {
                  return LoadingWidget(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                  );
                }
              },
            ),
            SizedBox(
              height: 12,
            ),
          ]),
    );
  }

  Widget buildBodyChild(BuildContext context) {
    return Column(children: <Widget>[
      Container(
       
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.17, 0, MediaQuery.of(context).size.width * 0.17, 0),
        decoration: new BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            border: new Border.all(width: 0.05, color: Colors.grey),
            borderRadius: const BorderRadius.all(const Radius.circular(16))),
        child: TextField(
          decoration: new InputDecoration(
            hintText: 'Enter your username',
            contentPadding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.15,right:MediaQuery.of(context).size.width * 0.15),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
          controller: txtController,
          onSubmitted: _onSubmitted(txtController.text, context),
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: MaterialButton(
            height: MediaQuery.of(context).size.width * 0.118,
            minWidth: MediaQuery.of(context).size.width * 0.67,
            color: Color.fromARGB(255, 47, 220, 150),
            textColor: Colors.white,
            child: Text('Request OTP'),
            onPressed: () {
              _onSubmitted(txtController.text, context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(34.0),
                side: BorderSide(color: Colors.transparent))),
      ),
    ]);
  }

  _onSubmitted(String otpCode, BuildContext context) {
    if (otpCode.length != 0) {
      txtController.text = '';
      final requestOtpBloc = BlocProvider.of<RequestOtpBloc>(context);
      requestOtpBloc.add(RequestOtp(
          userCredential:
              UserCredential(username: otpCode, uuid: Uuid().v1())));
    }
  }
}
