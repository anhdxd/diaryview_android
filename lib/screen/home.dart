import 'package:flutter/material.dart';
import 'package:flutter_app/screen/todo.dart';
import 'package:flutter_app/utils.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:flutter_app/screen/inputpassword.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/screen/phonenumber.dart';

// ignore: non_constant_identifier_names
bool g_endSession = false;

class Home extends StatelessWidget {
  final List<NavigationBarItem> navBarItems = [
    NavigationBarItem(
        icon: const Icon(Icons.home), label: 'Home', color: Colors.blue),
    NavigationBarItem(
        icon: const Icon(Icons.settings),
        label: 'Settings',
        color: Colors.blue),
  ]; // Khai báo các mục của NavigationBar

  @override
  Widget build(BuildContext context) {
    // Check không hoạt động trong app
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 30),
    );
    // invalidateSessionForUserInactivity: const Duration(seconds: 30));

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      // } else
      if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        print("timeout app focus");
        g_endSession = true;
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        home: MyHomePage(
          navBarItems: navBarItems,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<NavigationBarItem> navBarItems;

  const MyHomePage({super.key, required this.navBarItems});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const ToDoScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Ứng dụng được kích hoạt (active), thực hiện hành động tại đây
      print('Ứng dụng đã được kích hoạt');
      if (g_endSession) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const InputPasswordPage()),
            ModalRoute.withName("/login"));
        g_endSession = false;
      }
      // Thực hiện các hành động khác tại đây
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.navBarItems.map((item) => item.build()).toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavigationBarItem {
  final Icon icon;
  final String label;
  final Color color;

  NavigationBarItem(
      {required this.icon, required this.label, required this.color});

  BottomNavigationBarItem build() {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
      backgroundColor: color,
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  void onTapChangePhone(BuildContext context) {
    // Điều hướng đến màn hình Đăng xuất
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông báo'),
        content: const Text('Bạn có muốn đăng xuất ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InputPasswordPage()),
                  ModalRoute.withName("/inputpassword"));
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  Widget customListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      tileColor: const Color.fromARGB(255, 219, 222, 226),
      leading: const Icon(
        Icons.phone_callback,
        size: 40,
      ), // Biểu tượng đăng xuất
      title: const Text('Đổi số điện thoại theo dõi',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 58, 61, 62))),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                leading: const Icon(
                  Icons.phone_callback,
                  size: 30,
                ), // Biểu tượng đăng xuất
                title: const Text('Đổi số điện thoại theo dõi',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 58, 61, 62))),
                onTap: () {
                  // Điều hướng đến màn hình Đăng xuất
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Thông báo'),
                      content: const Text('Bạn có muốn đăng xuất ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addIniFile("pwd", "");
                            addIniFile("otpverify", "0");

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PhoneInputPage()),
                                ModalRoute.withName("/inputphone"));
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (index == 1) {
              return ListTile(
                leading: const Icon(
                  Icons.restore_from_trash,
                  size: 30,
                ), // Biểu tượng đăng xuất
                title: const Text('Xóa dữ liệu nhật ký',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 58, 61, 62))),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Thông báo'),
                      content: const Text('Bạn có muốn xóa toàn bộ dữ liệu ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            deleteAllDiary();
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );

                  // Điều hướng đến màn hình Đăng xuất
                },
              );
            }
            return null;
          }),
    );
  }
}
