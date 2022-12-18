import 'dart:convert';
import 'package:http/http.dart';

List message_ids = [];

void main() async {
  Object email = await fetchEmail();
  fetchData(email);
}

var url =
    Uri.https("www.1secmail.com", "/api/v1/", {"action": "genRandomMailbox"});

Future<Object> fetchEmail() async {
  try {
    var response = await get(url);
    var email = json.decode(response.body)[0].toString();
    return email;
  } catch (err) {
    return err;
  }
}

fetchData(email) async {
  var login = email.split("@")[0];
  var domain = email.split("@")[1];

  var url2 = Uri.https("www.1secmail.com", "/api/v1/",
      {"action": "getMessages", "login": login, "domain": domain});

  print(url2);

  try {
    var resp = await get(url2);
    var respList = json.decode(resp.body);
  } catch (err) {
    return err;
  }

  // print(json.decode(message.body));
}
