import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/screen/inputpassword.dart';

class PwdCreatePage extends StatefulWidget {
  const PwdCreatePage({Key? key}) : super(key: key);

  @override
  State<PwdCreatePage> createState() => _PwdCreatePageState();
}

class _PwdCreatePageState extends State<PwdCreatePage> {
  final inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập mật khẩu lần đầu'),
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
            SizedBox(height: heightSize * 0.08, child: inputPwd()),
            SizedBox(height: heightSize * 0.1, child: loginButton()),
          ],
        ),
      ),
    );
  }

  LayoutBuilder inputPwd() {
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
                  hintText: 'Password',
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
        // Get json data from data.dat
        final pwd = inputController.text;
        if (pwd.isNotEmpty && pwd.length >= 6) {
          // Save password to file
          addIniFile('pwd', inputController.text);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Tạo mật khẩu thành công'),
              content: const Text(
                  'Tạo mật khẩu thành công, vui lòng nhấn OK để tiếp tục'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InputPasswordPage()),
                        ModalRoute.withName("/inputpwd"));
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          print("add password to file");
        } else {
          print("password is empty");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Nhập mật khẩu lần đầu'),
              content: const Text(
                  'Password không được để trống và phải từ 6 ký tự trở lên'),
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
            'Tạo mật khẩu',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
