import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:convert';


class WebAPI{

  String csrfToken = '';

  final cookieJar = CookieJar();
  final client = http.Client();
  String setCookieHeader = '';

  WebAPI._privateConstructor();

  // The single instance
  static final WebAPI _instance = WebAPI._privateConstructor();

  // A getter to access the instance
  static WebAPI get instance => _instance;


  Future<void> deleteDrill() async {
    print("ENTER delete_drill");

    final url = Uri.parse('http://84.46.252.156/web/node/21?_format=json');
    final response = await http.delete(
      url,
      headers: {
        'X-CSRF-Token': csrfToken,
        'Cookie': setCookieHeader,
      },
    );

    if (response.statusCode == 204) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Failed to create data');
      print('Response data: ${response.body}');
    }
    print("EXIT delete_drill");
  }

  Future<void> getDrillData() async {
    print("ENTER getDrillData");

    int id = 22;

    final url = Uri.parse('http://84.46.252.156/web/node/' + id.toString() +'?_format=json');
    final response = await http.get(
      url,
      headers: {
        'X-CSRF-Token': csrfToken,
        'Cookie': setCookieHeader,
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Failed to create data');
    }
    print("EXIT getDrillData");
  }


  String prepareRunData(List<DateTime> timedetails, int totalPoints){
    String res = '';

   for(int point = 0; point <  totalPoints; point++){
      if(0 == point){
        res += ",";
      }
      DateTime pointTime = timedetails[point];
      res += "{\"point\": ${point+1}, \"time\": \"${pointTime.hour}:${pointTime.minute}:${pointTime.second}\"}";
    }

    return res;
  }

  Future<bool> createDrill(String drillname, int totalPoints, List<DateTime> timedetails) async {
    print("ENTER createDrill");

    String field_drill_run = prepareRunData(timedetails, totalPoints);

    final username = "admin";
    final password =  "admin!@#";
    final credentials = '$username:$password';
    final basicAuth = 'Basic Auth ' + base64Encode(utf8.encode(credentials));

    final url = Uri.parse('http://84.46.252.156/web/node?_format=json');

    print("time now : "+DateTime.now().toIso8601String());
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-CSRF-Token': csrfToken,
        'Authorization': basicAuth,
        'Cookie': setCookieHeader,
      }, 
      body: jsonEncode({
        "type": [
          {
            "target_id": "drill"
          }
        ],
        "title": [
          {
            "value": "Send by flutter"
          }
        ],
        "field_drill_name": [
          {
            "value": drillname
          }
        ],
        "field_drill_key": [
          {
            "value": "unique_mac_key_12345"
          }
        ],
        "field_drill_time_date": [
          {
            "value": "2024-07-25T14:30:00+00:00"//DateTime.now().toIso8601String()
          }
        ],
        "field_drill_run": [
          {
            "value": field_drill_run
          }
        ],
        "field_drill_additional_details": [
          {
            "value": "{\"durationSeconds\": 50, \"totalPoints\": $totalPoints, \"caloriesBurned\": 100, \"intensity\": \"high\", \"notes\": \"First drill of the day, focused on speed.\"}"
          }
        ]
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Failed to create data');
      print('Response data: ${response.body}');
    }
    print("EXIT createDrill");
    return false;
  }

  Future<void> deletUser() async {
    print("ENTER deletUser");

    final url = Uri.parse('http://84.46.252.156/web/user/9?_format=json');
    final response = await http.delete(url);

    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 204) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Response data: ${response.body}');
      print('Failed to create data');
    }
    print("EXIT deletUser");
  }




  Future<void> updateUser(String name, String email) async {
    print("ENTER updateUser");

    final url = Uri.parse('http://84.46.252.156/web/user/10?_format=json');


    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-CSRF-Token': csrfToken,
        'Cookie': setCookieHeader,
      }, 
      body: jsonEncode({
          "uid": [
              {
                  "value": 10
              }
          ],
          "uuid": [
              {
                  "value": "7aed129b-9e2c-4082-b38b-428ef341bc99"//"7aa78c40-10bd-4fc9-8e5b-905da346c9bd"
              }
          ],
          "langcode": [
              {
                  "value": "en"
              }
          ],
          "preferred_langcode": [
              {
                  "value": "en"
              }
          ],
          "preferred_admin_langcode": [],
          "name": [
              {
                  "value": name
              }
          ],
          "mail": [
              {
                  "value": email
              }
          ],
          "timezone": [
              {
                  "value": "UTC"
              }
          ],
          "status": [
              {
                  "value": true
              }
          ],
          "created": [
              {
                  "value": "2024-07-31T08:42:26+00:00",
                  "format": "Y-m-d\\TH:i:sP"
              }
          ],
          "changed": [
              {
                  "value": "2024-07-31T08:42:26+00:00",
                  "format": "Y-m-d\\TH:i:sP"
              }
          ],
          "access": [
              {
                  "value": "1970-01-01T00:00:00+00:00",
                  "format": "Y-m-d\\TH:i:sP"
              }
          ],
          "login": [
              {
                  "value": "1970-01-01T00:00:00+00:00",
                  "format": "Y-m-d\\TH:i:sP"
              }
          ],
          "init": [],
          "roles": [{
              "target_id": "administrator"
          }],
          "default_langcode": [
              {
                  "value": true
              }
          ],
          "user_picture": []
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Response data: ${response.body}');
      print('Failed to create data');
    }
    print("EXIT updateUser");
  }

  Future<void> getUserDetail() async {
    print("ENTER get_user_detail");

    final url = Uri.parse('http://84.46.252.156/web/user/1?_format=json');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-CSRF-Token': csrfToken,
        'Cookie': setCookieHeader,
      }
      );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Failed to create data');
    }
    print("EXIT get_user_detail");
  }

  
  Future<void> registerUser(String name, String email) async {
    print("ENTER registerUser");

    final url = Uri.parse('http://84.46.252.156/web/user/register?_format=json');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-CSRF-Token': csrfToken,
        'Cookie': setCookieHeader,
      }, 
      body: jsonEncode({
          "name": {
              "value": "sandeep6"
          },
          "mail": {
              "value": "sandeep6@example.com"
          }, 
          "status":{
              "value": 3
          }
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Response data: ${response.body}');
      print('Failed to create data');
      
    }
    print("EXIT registerUser");
  }




  Future<bool> loging() async {
    print("ENTER loging");

    final url = Uri.parse('http://84.46.252.156/web/user/login?_format=json');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }, 
      body: jsonEncode({"name":"admin", "pass":"admin!@#"}),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 201 CREATED response, parse the JSON
      print('Response data: ${response.body}');

      // Store cookies in the cookie jar
      setCookieHeader = response.headers['set-cookie']!;
      if (setCookieHeader != null) {
        final cookies = parseSetCookieHeader(setCookieHeader);
        cookieJar.saveFromResponse(url, cookies);
      }
      

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if(null == jsonResponse['csrf_token']){
        print("csrf_token not available");
      }else{
        csrfToken = jsonResponse['csrf_token']!;
        print("csrf_token : " + csrfToken);
        return true;
      }

    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      print('Failed to create data');
      
    }
    
    print("EXIT loging");
    return false;
  }


  List<Cookie> parseSetCookieHeader(String setCookieHeader) {
    print("ENTER parseSetCookieHeader");
    final cookies = <Cookie>[];
    final cookieParts = setCookieHeader.split(';');

    for (var part in cookieParts) {
      try {
        if (part.contains('=')) {
          cookies.add(Cookie.fromSetCookieValue(part.trim()));
        }
      } catch (e) {
        print('Error parsing cookie part: $e');
      }
    }
    print("EXIT parseSetCookieHeader");
    return cookies;
  }
}