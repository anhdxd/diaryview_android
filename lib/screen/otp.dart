import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils.dart';

import 'package:flutter_app/screen/createpassword.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // Add controller
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  // add parameter phoneNumber
  String phoneNumber = '';
  String otp = '';
  @override
  Widget build(BuildContext context) {
    phoneNumber = widget.phoneNumber;
    var heightSize = MediaQuery.of(context).size.height;
    var widthSize = MediaQuery.of(context).size.width;
    double otpWidth = 56;
    double otpHeight = 54;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập OTP'),
        titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: heightSize * 0.1,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              ),
            ),
            SizedBox(
              height: heightSize * 0.03,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Nhập 6 ký tự nhận được từ SMS tới số điện thoại:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: heightSize * 0.03,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  phoneNumber,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // const SizedBox(height: 50,),
            SizedBox(
              // create padding

              height: heightSize * 0.2,
              width: widthSize * 0.95,
              // center screen

              child: Form(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldOne,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldTwo,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldThree,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldFour,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldFive,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: otpHeight,
                    width: otpWidth,
                    child: TextFormField(
                      controller: _fieldSix,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.cyan[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan)),
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(height: heightSize * 0.1, child: OtpButton()),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector OtpButton() {
    return GestureDetector(
      onTap: () async {
        otp = _fieldOne.text +
            _fieldTwo.text +
            _fieldThree.text +
            _fieldFour.text +
            _fieldFive.text +
            _fieldSix.text;
        print("verity OTP");
        var verify = false;
        await verifyOTP(phoneNumber, otp).then((bool value) => {
              verify = value,
            });

        if (verify) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const PwdCreatePage()),
              ModalRoute.withName("/createpwd"));
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Xác thực OTP thành công'),
          ));

          await uploadPublicKey(phoneNumber);

          // save otp to file config
          addIniFile('otpverify', '1');
          addIniFile('phone', phoneNumber);
          //addIniFile('token', token);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Quá trình xác thực OTP thất bại'),
          ));
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
            'Verify',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
