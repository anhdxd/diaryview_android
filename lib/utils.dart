// ignore_for_file: avoid_print
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:fast_rsa/fast_rsa.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

const ipServer = 'http://52.188.166.206:5000'; //'http://10.0.2.2:5000';
// Hiện tại đang là giả cầy gửi otp + public + token. Đẩy nhanh tiến độ nên k sửa nữa, sửa khi làm đồ án
// upload key
Future<void> uploadPublicKey(String phone) async {
  // String token = '';
  // await getSerial().then((value) => token = value);
  String token = await getIniFile("token");
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  // token = androidInfo.hardware.toString() + androidInfo.id.toString();

  // Generate 2048 RSA key
  final key = await RSA.generate(2048);
  final publickeyPKIX = await RSA
      .convertPublicKeyToPKIX(key.publicKey); // định dạng web có thể mã hóa
  //final privatekeyPKIX = await RSA.convertPrivateKeyToPKCS8(key.privateKey);
  //print('privatekey:$privatekeyPKIX');

  // Save private key in app file
  final privateKey = key.privateKey.toString();
  final fpath = await getApplicationDocumentsDirectory();
  final file = File('${fpath.path}/privatekey.txt');
  file.writeAsStringSync(privateKey);

  // Create http post request with json
  final url = Uri.parse('$ipServer/sync/uploadpublickey');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
          {'phone': phone, 'publickey': publickeyPKIX, 'token': token}));
  print(response.body);
}

// post json to /verify_phone_number
Future<void> verifyPhoneNumber(phone) async {
  final url = Uri.parse('$ipServer/verify_phone_number');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': phone}));
  print(response.body);
}

// post json to /delete_all_diary
Future<void> deleteAllDiary() async {
  final url = Uri.parse('$ipServer/delete_all_diary');
  final token = await getIniFile("token");
  final phone = await getIniFile("phone");
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token, 'phone': phone}));
  print(response.body);
}

// post json (phone, otp) to /verify_otp
Future<bool> verifyOTP(phone, otp) async {
  final url = Uri.parse('$ipServer/verify_otp');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': phone, 'otp': otp}));
  print(response.body);
  if (response.statusCode == 200 && response.body != "") {
    final result = await addIniFile("token", response.body);
    if (result) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

// **************************************************************************
// download diary data
Future<String> getDiaryFromServer(String phone, String inToken) async {
  String token = inToken;
  if (token.isEmpty || token == '') {
    token = await getIniFile("token");
  }

  final url = Uri.parse('$ipServer/sync/download');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': phone, 'token': token}));

  //print(response.body);
  if (response.body == "") {
    return "";
  }
  // Data parse
  var jsonData = json.decode(response.body)['data'];
  if (jsonData == "" || jsonData == null) {
    return "";
  }
  var aesKeyEnc = json.decode(jsonData.toString())['aes'];
  var dataEnc = json.decode(jsonData.toString())['data_enc'];

  // decrypt rsa-2048, read key in path app privatekey.txt
  final fpath = await getApplicationDocumentsDirectory();
  final file = File('${fpath.path}/privatekey.txt');
  final privateKey = file.readAsStringSync();

  // decrypt with RSA

  var aesKey = await RSA.decryptPKCS1v15(aesKeyEnc, privateKey);

  // decrypt with aes 256 with iv = anhdz123anhdz123
  String aesDecrypted = decryptAes(aesKey, 'anhdz123anhdz123', dataEnc);
  //print(aesDecrypted);
  return aesDecrypted; //decrypted;
}

// ************************** encrypt ****************************
// decrypt aes-256
String decryptAes(String key, String iv, String encrypted) {
  final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8(key), mode: encrypt.AESMode.cbc));
  final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(encrypted),
      iv: encrypt.IV.fromUtf8(iv));
  return decrypted;
}

// ************************** info system and app ****************************
// Get serial
Future<String> getSerial() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.hardware.toString() + androidInfo.id.toString();
}

// create function ini
Future<bool> addIniFile(String key, String value) async {
  final fpath = await getApplicationDocumentsDirectory();
  final file = File('${fpath.path}/config.ini');

  Map<String, dynamic> config = {};
  if (file.existsSync()) {
    try {
      config = jsonDecode(file.readAsStringSync());
    } catch (e) {
      print('Exception jsonDecode: $e');
      file.deleteSync();
    }
  }
  try {
    config[key] = value;

    final jsonConfig = jsonEncode(config);
    file.writeAsStringSync(jsonConfig, flush: true);
  } catch (e) {
    print('exception addIniFile: $e');
    return false;
  }

  return true;
}

Future<String> getIniFile(String key) async {
  final fpath = await getApplicationDocumentsDirectory();
  final file = File('${fpath.path}/config.ini');
  String value = '';

  Map<String, dynamic> config = {};
  if (file.existsSync()) {
    try {
      config = jsonDecode(file.readAsStringSync());
      value = config[key].toString();
    } catch (e) {
      print('Exception get ini file jsonDecode: $e');
      return '';
    }
  }

  return value;
}
