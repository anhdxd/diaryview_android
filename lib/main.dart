// ignore_for_file: avoid_print, use_build_context_synchronously
//import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:flutter/material.dart';

import 'package:flutter_app/screen/phonenumber.dart';
import 'package:flutter_app/screen/inputpassword.dart';
import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final key = await RSA.generate(2048);
  // final publickeyPKIX = await RSA
  //     .convertPublicKeyToPKIX(key.publicKey); // định dạng web có thể mã hóa
  // final privatekeyPKIX = await RSA.convertPrivateKeyToPKCS8(key.privateKey);
  // print(privatekeyPKIX);
  //getDiaryFromServer('0866726000', '');
  // final key = await RSA.generate(2048);
  // final publickey = await RSA
  //     .convertPublicKeyToPKIX(key.publicKey); // định dạng web có thể mã hóa
  // print(publickey);
  // String? ver = await getIniFile('config', 'otpverify');

  final vertifyPhone = await getIniFile('otpverify');
  final password = await getIniFile('pwd');
  //await addIniFile('pwd', '');
  String route = '/';
  // read ini file
  if (vertifyPhone == '1' && password != '' && password != 'null') {
    route = '/inputpassword';
  } else {
    route = '/inputphone';
  }

  MyApp app = MyApp(
    initialRoute: route,
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: initialRoute,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/inputphone': (context) => const PhoneInputPage(),
        '/inputpassword': (context) => const InputPasswordPage(),
        //'/inputpassword': (context) => const InputPasswordPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/inputphone': (context) => const InputPhone(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  String path = '';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      try {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PhoneInputPage()),
            ModalRoute.withName("/inputphone"));
      } catch (e) {
        print(e);
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   (() async {
  //     final vertifyPhone = await getIniFile('otpverify');

  //     // read ini file
  //     if (vertifyPhone == '1') {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const PhoneInputPage()),
  //           ModalRoute.withName("/inputpassword"));
  //     } else {}
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Create input phone number screen


 // const plainText = 'Hello, world!';
  // final key = encrypt.Key.fromUtf8('my 32 length key................');
  // final iv = encrypt.IV.fromUtf8('my 16 length iv.');
  // final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // final encrypted = encrypter.encrypt(plainText, iv: iv);
  // print(encrypted.base64); // prints: vL7e3QH7Zl5R5p6e9BMT9w==

  // final decrypted = encrypter.decrypt(encrypted, iv: iv);
  // print(decrypted); // prints: Hello, world!

  // // **************** REQUEST
  // var url =
  //     Uri.parse('http://qldt.actvn.edu.vn/CMCSoft.IU.Web.info/Login.aspx');
  // var response = await http.get(url);
  // print('Response status: ${response.statusCode}');
  // //print('Response body: ${response.body}');

  // // ****************** RSA
  // var message = "Hello, world!";
  // var rsaKey = await RSA.generate(2048);

  // var z = rsaKey.publicKey.characters;
  // print(z.string);

  // var result =
  //     await RSA.encryptOAEP(message, "SHA-256", Hash.SHA256, rsaKey.publicKey);
  // print(result);
  //runApp(const MyApp());

  // ***************** SQLITE
  // sqflite_ffi.sqfliteFfiInit();
  // databaseFactory = sqflite_ffi.databaseFactoryFfi;

  // // In ra đường dẫn thư mục database
  // print("db path: ${await getDatabasesPath()}");

  // final db = await openDatabase(
  //   join(await getDatabasesPath(), 'my_database.db'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //       'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  //     );
  //   },
  //   version: 1,
  // );

  // await db.close();