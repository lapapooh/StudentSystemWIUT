import 'package:flutter/material.dart';
import 'package:student_system_flutter/bloc/attendance_bloc/attendance_bloc.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = AttendanceBloc();
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendance QR Scan'),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    color: Theme.of(context).accentColor,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: bloc.scan,
                    child: const Text('SCAN')),
              ),
              StreamBuilder(
                stream: bloc.qrResult,
                builder: (context, snapshot) => snapshot.hasData
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20.0),
                        child: Text(
                          snapshot.data,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ));
  }
}