import 'package:flutter/material.dart';
import 'package:flutter_app/screen/otp.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter/services.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({Key? key}) : super(key: key);

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập OTP'),
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
                Icons.phone,
                color: Colors.cyan,
              ),
              title: TextField(
                controller: inputController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  hintText: 'Mobile',
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
        String phone = inputController.text;
        if (phone.length < 10) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Thông báo'),
              content:
                  const Text('Số điện thoại không hợp lệ. Vui lòng nhập lại!'),
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
        verifyPhoneNumber(phone);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OtpPage(phoneNumber: phone);
        }));
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
            'Nhận OTP',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
