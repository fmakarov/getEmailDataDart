import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  Object email = await fetchEmail();
  fetchData(email);
  while (true) {
    await fetchData(email);
    await Future.delayed(Duration(seconds: 20));
  }
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

fetchData(email) async {
  var login = email.split("@")[0];
  var domain = email.split("@")[1];

  print(email);

  var url2 = Uri.http("www.1secmail.com", "/api/v1/",
      {"action": "getMessages", "login": login, "domain": domain});
//Future<void> fetchData();

  while (true) {
    try {
      var resp = await http.get(url2);
      var respList = json.decode(resp.body);
      //print(respList);

      var m_id = respList[0]["id"];
      print(m_id);
      var url3 = Uri.http("www.1secmail.com", "/api/v1/", {
        "action": "readMessage",
        "login": login,
        "domain": domain,
        "id": m_id
      });
      var url33 = http.get(url3);
      print(url33);
    } catch (err) {
      return err;
    }
    await Future.delayed(Duration(seconds: 20));
  }
}
