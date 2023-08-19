import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/providers/bottom_navigation_bar_provider.dart';
import 'package:warikanking_frontend/usecases/signout_usecase.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';
import 'package:warikanking_frontend/views/accounts/my_page.dart';
import 'package:warikanking_frontend/views/accounts/qr_page.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';
import 'package:warikanking_frontend/views/events/event_list_page.dart';
import 'package:warikanking_frontend/views/events/event_qr_page.dart';
import 'package:warikanking_frontend/views/events/new_event_page.dart';

class Screen extends StatefulWidget {
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();

  }

  List<Widget> pageList = [
    EventListPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context,''),
      drawer: Drawer(
        child: ListView(
          children: [
            // UserAccountsDrawerHeader(
            //   accountName: Text(me.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            //   accountEmail: Text(me.comment,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            //   // onDetailsPressed: () {
            //   //   Navigator.push(
            //   //     context,
            //   //     MaterialPageRoute(builder: (context) => Screen()),
            //   //   );
            //   // },
            // ),
            // ListTile(
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: const [
            //       Icon(Icons.qr_code),
            //       Text(' QR'),
            //     ],
            //   ),
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => QrPage()),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: const [
            //       Icon(Icons.settings_outlined),
            //       Text(' 設定'),
            //     ],
            //   ),
            //   onTap: (){
            //
            //   },
            // ),
            ListTile(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text("ログアウト"),
                        content: Text("からログアウトしますか？"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () => Navigator.pop(context),
                            child: const Text("キャンセル"),
                          ),
                          CupertinoDialogAction(
                              child: const Text("ログアウト"),
                              onPressed: () async {
                                await SignoutUsecase.signoutUsecase();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SigninPage()),
                                );
                              }
                          ),
                        ],
                      );
                    }
                );
              },

              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.logout_outlined),
                  Text(' ログアウト'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: pageList[bottomNavigationBar.currentIndex],
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: Colors.greenAccent,
      //   onTap:(index){
      //     bottomNavigationBar.currentIndex = index;
      //   } ,
      //   items: const [
      //     Icon(Icons.event),
      //     Icon(Icons.perm_identity_outlined),
      //   ],
      // ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag:'qr',
              backgroundColor: Colors.white,
              child: const Icon(Icons.qr_code_scanner_outlined, color: Colors.green,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrScanView()),
                );
              }
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.add, color: Colors.green,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEventPage()),
                );
              }
          ),
        ],
      ),
    );
  }
}