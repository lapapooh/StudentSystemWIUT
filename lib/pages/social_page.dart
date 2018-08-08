import 'package:flutter/material.dart';
import 'package:student_system_flutter/helpers/function_helpers.dart';
import '../helpers/app_constants.dart';
import '../list_items/item_posts.dart';

class SocialPage extends StatelessWidget {
  final String _title = 'WIUT Feed';

  @override
  Widget build(BuildContext context) {
    showInfiniteFlushBar(
        Icon(
          Icons.info,
          color: Colors.white,
        ),
        info,
        featureNotImplemented,
        greyColor,
        context);

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).accentColor),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              _title,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
            ],
            bottom: TabBar(
              labelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).accentColor,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.mail)),
                Tab(icon: Icon(Icons.star)),
                Tab(icon: Icon(Icons.search))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 40,
                  itemBuilder: (context, i) => ItemPosts(positionIndex: i),
                ),
              ),
              Icon(Icons.mail),
              Icon(Icons.star),
              Icon(Icons.search),
            ],
          ),
          // bottomNavigationBar: BottomAppBar(
          //     color: Colors.blue,
          //     hasNotch: true,
          //     elevation: 5.0,
          //     child: ButtonBar(
          //       alignment: MainAxisAlignment.start,
          //       children: <Widget>[
          //         Icon(
          //           Icons.settings,
          //           color: Colors.white,
          //         ),
          //       ],
          //     )),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(tweetPage);
            },
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
