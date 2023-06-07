import 'package:flutter/material.dart';
import 'package:flutter_app/screen/otp.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/screen/home.dart';


class InputPasswordPage extends StatefulWidget {
  const InputPasswordPage({Key? key}) : super(key: key);

  @override
  State<InputPasswordPage> createState() => _InputPasswordPageState();
}

class _InputPasswordPageState extends State<InputPasswordPage> {
  final inputController = TextEditingController();
  var password = '';

  @override
  void initState() {
    super.initState();
    getIniFile('pwd').then((value) {
      setState(() {
        password = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập mật khẩu'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: heightSize * 0.07,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
              ),
            ),
            SizedBox(height: heightSize * 0.08, child: phoneLogin()),
            SizedBox(height: heightSize * 0.1, child: loginButton()),
          ],
        ),
      ),
    );
  }

  LayoutBuilder phoneLogin() {
    return LayoutBuilder(builder: (context, hw) {
      return Column(
        children: [
          SizedBox(
            child: ListTile(
              horizontalTitleGap: 10,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              leading: const Icon(
                Icons.key,
                color: Colors.cyan,
              ),
              title: TextField(
                controller: inputController,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Mật khẩu',
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  GestureDetector loginButton() {
    return GestureDetector(
      onTap: () {
        String inputPwd = inputController.text;
        //verifyPhoneNumber(phone);
        if (inputPwd == password) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              ModalRoute.withName("/home"));
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Đã xảy ra lỗi'),
              content: const Text('Mật khẩu sai, vui lòng nhập lại mật khẩu'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
      },
      child: Center(
        child: Container(
          width: 340,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
              child: Text(
            'Xác nhận',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
