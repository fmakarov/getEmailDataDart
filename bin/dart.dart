import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() async {
  Object email = await fetchEmail();
  await Future.delayed(Duration(seconds: 1));
  fetchData(email);
}

var url =
    Uri.https("www.1secmail.com", "/api/v1/", {"action": "genRandomMailbox"});

Future<Object> fetchEmail() async {
  try {
    var response = await http.get(url);
    var email = json.decode(response.body)[0].toString();
    return email;
  } catch (err) {
    return err;
  }
}

Future checkMail(url2, email) async {
  try {
    var resp = await http.get(url2);
    var respList = json.decode(resp.body);

    var messageId = respList[0]["id"];
    var text = respList[0]["subject"];

    print("messageId: $messageId, subject message: $text");

  } catch (err) {
    return err;
  }
}

Future fetchData(email) async {
  var login = email.split("@")[0];
  var domain = email.split("@")[1];

  var url2 = Uri.http("www.1secmail.com", "/api/v1/",
      {"action": "getMessages", "login": login, "domain": domain});

  Timer checkEmail = Timer.periodic(Duration(seconds: 6), (timer) {
    checkMail(url2, email);
  });

  print("Start check message: $email");

  checkEmail;
}

