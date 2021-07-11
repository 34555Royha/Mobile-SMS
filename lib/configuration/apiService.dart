import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

    //Set Token
  void setApiKey(strToken) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', strToken);
  }

  //Get Token
  Future<String> getApiKey() async {
    var prefs = await SharedPreferences.getInstance();
    var apiKey = prefs.getString('apiKey');
    return apiKey;
  }

  //Setprefs
  void setPrefs(String key, String text) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, text);
  }

//getprefs
  Future<String> getPrefs(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  



    // ========================No Security===============================

    Future<Response> getNoToken({String url}) async {
      var response =  await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
      });
    return response;
    }

      Future<Response> postAPINoToken({String url, String body}) async {
    var x = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: body,
    );
    return x;
  }

  
  // ========================Security===============================

  Future<Response> getAPIWithToken({String url}) async {
    var x = await http.get(Uri.parse(url), headers: {
      // "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Basic dmluYToxMjM=",
    });





























































































































































































































































































































































































































































































































































































































































































































































    
    return x;
  }

  Future<Response> deleteWithToken({String url}) async {
    return await http.delete(
      url,
      headers: {
         "Authorization":  await getApiKey(),
        // "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
  }

    Future<Response> postAPIWithToken({String url, String body}) async {
    var x = await http.post(
      url,
      headers: {
         "Authorization":  await getApiKey(),
        "Content-Type": "application/json",
        // "Accept": "application/json",
      },
      body: body,
    );
    return x;
  }

      Future<Response> putAPIWithToken({String url, String body}) async {
    var x = await http.put(
      url,
      headers: {
        "Authorization":  await getApiKey(),
        "Content-Type": "application/json",
        // "Accept": "application/json",
      },
      body: body,
    );
    return x;
  }

}
