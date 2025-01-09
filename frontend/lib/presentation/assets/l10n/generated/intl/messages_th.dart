// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a th locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'th';

  static String m0(name) => "ช่อง: ${name}";

  static String m1(amount) => "ระยะเวลา: ${amount}";

  static String m2(provider) => "เข้าสู่ระบบด้วย ${provider}";

  static String m3(provider) => "สมัครสมาชิกด้วย ${provider}";

  static String m4(amount) => "จำนวนการดู: ${amount}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authGreetingsLogin":
            MessageLookupByLibrary.simpleMessage("ดีใจที่ได้พบคุณอีกครั้ง!"),
        "authGreetingsSignUp": MessageLookupByLibrary.simpleMessage(
            "มาร่วมกับเราและฟังเสียงหัวใจของคุณเต้น!"),
        "channel": m0,
        "clipboardShareMusic": MessageLookupByLibrary.simpleMessage(
            "🔗 คัดลอกลิงก์ไปยังคลิปบอร์ดแล้ว! 🎉"),
        "downloadedMusic": MessageLookupByLibrary.simpleMessage("ที่ดาวน์โหลด"),
        "duration": m1,
        "email": MessageLookupByLibrary.simpleMessage("อีเมล"),
        "emailTip":
            MessageLookupByLibrary.simpleMessage("nickname@example.com"),
        "favoriteMusic": MessageLookupByLibrary.simpleMessage("รายการโปรด"),
        "forgotPwd": MessageLookupByLibrary.simpleMessage("ลืมรหัสผ่าน?"),
        "hasAccount":
            MessageLookupByLibrary.simpleMessage("ฉันมีบัญชีอยู่แล้ว!"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("กรุณากรอกอีเมลที่ถูกต้อง."),
        "invalidForm": MessageLookupByLibrary.simpleMessage(
            "แบบฟอร์มไม่ถูกต้อง! กรุณาตรวจสอบข้อมูลในช่องกรอก"),
        "invalidFormat":
            MessageLookupByLibrary.simpleMessage("รูปแบบไม่ถูกต้อง."),
        "invalidNumber":
            MessageLookupByLibrary.simpleMessage("กรุณากรอกตัวเลขที่ถูกต้อง."),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("รหัสผ่านไม่ถูกต้อง."),
        "listenMusic": MessageLookupByLibrary.simpleMessage("ฟังเพลง"),
        "login": MessageLookupByLibrary.simpleMessage("เข้าสู่ระบบ"),
        "loginWith": m2,
        "logout": MessageLookupByLibrary.simpleMessage("ออกจากระบบ"),
        "menu": MessageLookupByLibrary.simpleMessage("เมนู"),
        "noAccount": MessageLookupByLibrary.simpleMessage("ฉันไม่มีบัญชี!"),
        "noResultsFound": MessageLookupByLibrary.simpleMessage(
            "ไม่พบผลลัพธ์ โปรดลองค้นหาด้วยคำอื่น"),
        "noTitle": MessageLookupByLibrary.simpleMessage("ไม่มีชื่อเรื่อง"),
        "noViews": MessageLookupByLibrary.simpleMessage("ไม่มีการรับชม"),
        "password": MessageLookupByLibrary.simpleMessage("รหัสผ่าน"),
        "passwordTip": MessageLookupByLibrary.simpleMessage(
            "8+ ตัวอักษร, 1 ตัวพิมพ์ใหญ่, 1 ตัวพิมพ์เล็ก, 1 ตัวเลข, 1 สัญลักษณ์ (@, #, \$)"),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("ช่องนี้จำเป็นต้องกรอก."),
        "search": MessageLookupByLibrary.simpleMessage("ค้นหา"),
        "searchBarPhrase":
            MessageLookupByLibrary.simpleMessage("ค้นหาเพลงที่นี่..."),
        "searchErrorMessage": MessageLookupByLibrary.simpleMessage(
            "เกิดข้อผิดพลาดขณะค้นหา โปรดลองใหม่อีกครั้งในภายหลัง"),
        "selectedLanguage": MessageLookupByLibrary.simpleMessage("ภาษา"),
        "signUp": MessageLookupByLibrary.simpleMessage("สมัครสมาชิก"),
        "signUpWith": m3,
        "unknowErrorMessage": MessageLookupByLibrary.simpleMessage(
            "เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งภายหลัง"),
        "unknownChannel":
            MessageLookupByLibrary.simpleMessage("ช่องไม่ทราบชื่อ"),
        "unknownDuration":
            MessageLookupByLibrary.simpleMessage("ระยะเวลาไม่ทราบ"),
        "views": m4
      };
}
