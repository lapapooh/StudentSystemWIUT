import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_system_flutter/bloc/backdrop/backdrop_bloc.dart';
import 'package:student_system_flutter/bloc/backdrop/backdrop_provider.dart';
import 'package:student_system_flutter/enums/ApplicationEnums.dart';
import 'package:student_system_flutter/helpers/backdrop_menu.dart';
import 'package:student_system_flutter/pages/modules_page.dart';

import '../helpers/app_constants.dart';
import '../helpers/function_helpers.dart';
import '../helpers/ui_helpers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  var _bloc = BackdropBloc();

  @override
  void initState() {
    super.initState();

    getMinimumAppVersion(context);

    getUserProfileForTheCurrentYear();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  Widget _buildSignOutAction() {
    return IconButton(
      padding: EdgeInsets.only(top: 1.0),
      icon: Image.asset(
        Platform.isAndroid
            ? 'assets/exit_run.png'
            : 'assets/exit_run_black.png',
        height: 22.0,
      ),
      onPressed: () {
        showSignOutDialog(context);
      },
    );
  }

  Widget _buildMenuAction() {
    return IconButton(
      onPressed: () {
        controller.fling(velocity: _bloc.isBackdropPanelHidden ? -1.0 : 1.0);

        _bloc.setBackdropPanelHidden.add(!_bloc.isBackdropPanelHidden);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        progress: controller.view,
        color: Platform.isAndroid ? Colors.white : blackColor,
      ),
    );
  }

  // bool get isPanelVisible {
  //   final AnimationStatus status = controller.status;
  //   return status == AnimationStatus.completed ||
  //       status == AnimationStatus.forward;
  // }

  Widget _getIOSWidgets() {
    return Material(
      color: Colors.transparent,
      child: CupertinoPageScaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        navigationBar: CupertinoNavigationBar(
            leading: _buildMenuAction(),
            middle: Text("WIUT"),
            trailing: _buildSignOutAction()),
        child: TwoPanels(
          controller: controller,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (!_bloc.isBackdropPanelHidden) {
      controller.fling(velocity: _bloc.isBackdropPanelHidden ? -1.0 : 1.0);

      _bloc.setBackdropPanelHidden.add(!_bloc.isBackdropPanelHidden);
    }

    return _bloc.isBackdropPanelHidden;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? RepaintBoundary(
            child: BackdropProvider(
              bloc: _bloc,
              child: WillPopScope(
                onWillPop: _onBackPressed,
                child: Scaffold(
                    appBar: AppBar(
                        elevation: 0.0,
                        centerTitle: true,
                        title: Text('WIUT'),
                        actions: <Widget>[
                          _buildSignOutAction(),
                        ],
                        leading: _buildMenuAction()),
                    body: TwoPanels(
                      controller: controller,
                    )),
              ),
            ),
          )
        : RepaintBoundary(
            child: BackdropProvider(bloc: _bloc, child: _getIOSWidgets()));
  }
}

void openSelectedPage(BuildContext context, MainPageGridItems page) {
  switch (page) {
    case MainPageGridItems.MARKS:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ModulesPage(requestType: RequestType.GetMarks)));
      break;
    case MainPageGridItems.TIMETABLE:
      Navigator.of(context).pushNamed(timetablePage);
      break;
    case MainPageGridItems.LEARNING_MATERIALS:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ModulesPage(requestType: RequestType.GetTeachingMaterials)));
      break;
    case MainPageGridItems.OFFENCES:
      // Navigator.of(context).pushNamed(offencesPage);
      Navigator.of(context).pushNamed(offencesPage);
      break;
    case MainPageGridItems.COURSEWORK_UPLOAD:
      Navigator.of(context).pushNamed(courseworkUploadPage);
      break;
    case MainPageGridItems.BOOK_ORDERING:
      Navigator.of(context).pushNamed(booksPage);
      break;
    case MainPageGridItems.SOCIAL:
      Navigator.of(context).pushNamed(socialPage);
      break;
    case MainPageGridItems.CCMFEEDBACK:
      Navigator.of(context).pushNamed(ccmCategoryPage);
      break;
    default:
      print('Nothing');
  }
}

class CustomGridView {
  BuildContext context;
  bool isCCMFeedbackApllicable;

  CustomGridView(this.context, this.isCCMFeedbackApllicable);

  Widget makeGridCell(
      String name, String imageSource, MainPageGridItems page, int position) {
    var size = MediaQuery.of(context).size;
    bool isSmallScreen = false;

    if (size.width <= smallDeviceWidth) {
      isSmallScreen = true;
    }

    return Padding(
      padding: position.isEven
          ? EdgeInsets.only(left: 18.0, bottom: 10.0)
          : EdgeInsets.only(right: 18.0, bottom: 10.0),
      child: CustomCard(
        InkWell(
          onTap: () {
            openSelectedPage(context, page);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  imageSource,
                  height: 60.0,
                )),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Text(
                  name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1.copyWith(
                      letterSpacing: 4.0,
                      color: textColor,
                      fontSize: isSmallScreen ? 11.0 : 15.0),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid build() {
    // var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    // final double itemWidth = size.width / 1.55;

    return SliverGrid.count(
        // padding: EdgeInsets.all(16.0),
        // shrinkWrap: true,
        childAspectRatio: 0.9, //0.85
        // scrollDirection: Axis.vertical,
        // controller: ScrollController(keepScrollOffset: false),
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
        children: isCCMFeedbackApllicable
            ? <Widget>[
                // SliverToBoxAdapter(
                // SliverToBoxAdapter(
                //   child: SliverGrid.count(
                //     crossAxisCount: 2,
                //     children: <Widget>[
                makeGridCell(
                    "Marks", 'assets/marks.png', MainPageGridItems.MARKS, 0),
                makeGridCell("Timetable", 'assets/timetable.png',
                    MainPageGridItems.TIMETABLE, 1),
                makeGridCell("Learning Materials", 'assets/lectures.png',
                    MainPageGridItems.LEARNING_MATERIALS, 2),

                makeGridCell("CCM Feedback", 'assets/ccmfeedback.png',
                    MainPageGridItems.CCMFEEDBACK, 3)
                //     ],
                //   ),
                // ),
              ]
            : <Widget>[
                makeGridCell(
                    "Marks", 'assets/marks.png', MainPageGridItems.MARKS, 0),
                makeGridCell("Timetable", 'assets/timetable.png',
                    MainPageGridItems.TIMETABLE, 1),
                makeGridCell("Learning Materials", 'assets/lectures.png',
                    MainPageGridItems.LEARNING_MATERIALS, 2),
              ]);
  }
}

class CustomGridView2 {
  BuildContext context;

  CustomGridView2(this.context);

  Widget makeGridCell(
      String name, String imageSource, MainPageGridItems page, int position) {
    var size = MediaQuery.of(context).size;
    bool isSmallScreen = false;

    if (size.width <= smallDeviceWidth) {
      isSmallScreen = true;
    }

    return Padding(
      padding: position.isEven
          ? EdgeInsets.only(left: 18.0, bottom: 10.0)
          : EdgeInsets.only(right: 18.0, bottom: 10.0),
      child: Opacity(
        opacity: 0.6,
        child: CustomCard(
          InkWell(
            onTap: () {
              openSelectedPage(context, page);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    imageSource,
                    height: 60.0,
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Text(
                    name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.body1.copyWith(
                        letterSpacing: 4.0,
                        color: textColor,
                        fontSize: isSmallScreen ? 11.0 : 15.0),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid build() {
    return SliverGrid.count(
        childAspectRatio: 0.9, //0.85

        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
        children: <Widget>[
          makeGridCell("Book ordering", 'assets/bookordering.png',
              MainPageGridItems.BOOK_ORDERING, 0),
          makeGridCell("Offences", 'assets/offences2.png',
              MainPageGridItems.OFFENCES, 1),
          makeGridCell("CW Upload", 'assets/cwupload.png',
              MainPageGridItems.COURSEWORK_UPLOAD, 2),
          makeGridCell(
              "Social", 'assets/social.png', MainPageGridItems.SOCIAL, 3),
        ]);
  }
}

class CustomGridViewForTeachers {
  BuildContext context;
  bool isCCMFeedbackApllicable;

  CustomGridViewForTeachers(this.context, this.isCCMFeedbackApllicable);

  Widget makeGridCell(
      String name, String imageSource, MainPageGridItems page, int position) {
    var size = MediaQuery.of(context).size;
    bool isSmallScreen = false;

    if (size.width <= smallDeviceWidth) {
      isSmallScreen = true;
    }

    return Padding(
      padding: position.isEven
          ? EdgeInsets.only(left: 18.0, bottom: 10.0)
          : EdgeInsets.only(right: 18.0, bottom: 10.0),
      child: CustomCard(
        InkWell(
          onTap: () {
            openSelectedPage(context, page);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  imageSource,
                  height: 60.0,
                )),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Text(
                  name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1.copyWith(
                      letterSpacing: 4.0,
                      color: textColor,
                      fontSize: isSmallScreen ? 11.0 : 15.0),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid build() {
    // var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    // final double itemWidth = size.width / 1.55;

    return SliverGrid.count(
        // padding: EdgeInsets.all(16.0),
        // shrinkWrap: true,
        childAspectRatio: 0.9, //0.85
        // scrollDirection: Axis.vertical,
        // controller: ScrollController(keepScrollOffset: false),
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
        children: isCCMFeedbackApllicable
            ? <Widget>[
                // SliverToBoxAdapter(
                // SliverToBoxAdapter(
                //   child: SliverGrid.count(
                //     crossAxisCount: 2,
                //     children: <Widget>[
                makeGridCell("Timetable", 'assets/timetable.png',
                    MainPageGridItems.TIMETABLE, 0),
                makeGridCell("Learning Materials", 'assets/lectures.png',
                    MainPageGridItems.LEARNING_MATERIALS, 1),
                makeGridCell("CCM Feedback", 'assets/ccmfeedback.png',
                    MainPageGridItems.CCMFEEDBACK, 2)

                //     ],
                //   ),
                // ),
              ]
            : <Widget>[
                makeGridCell("Timetable", 'assets/timetable.png',
                    MainPageGridItems.TIMETABLE, 0),
                makeGridCell("Learning Materials", 'assets/lectures.png',
                    MainPageGridItems.LEARNING_MATERIALS, 1),
              ]);
  }
}
