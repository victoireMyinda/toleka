// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/utils/string.util.dart';

class SignUpRepository {

   static Future<Map<String, dynamic>> login(String login, String password) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            "https://toleka.chlikabo.org/api/login.php"));

    request.body = json.encode({"login": login, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      //String? token = responseJson['token'];
      String? message = responseJson['message'];
      Map? data = responseJson['data'];

      //prefs.setString("token", token.toString());
      return {
        //"token": token,
        "status": statusCode,
        "message": message,
        "data": data
      };
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  

   static Future<Map<String, dynamic>> signup(
      Map data, BuildContext context) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST',
        Uri.parse(
            "https://toleka.chlikabo.org/api/inscription.php"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      //String? token = responseJson['token'];
      String? message = responseJson['message'];
      Map? data = responseJson['data'];

      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": data, "message": message};
    } else if (statusCode == 400) {
      return {"status": statusCode, "message": responseJson['message']};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> getAllVehicule() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            "https://toleka.chlikabo.org/api/vehicule.php"));

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map? responseJson = json.decode(responseBody);
    List? data = responseJson!['data'];

    if (response.statusCode == 200) {
      // print(data);
      return {
        "status": response.statusCode,
        "data": data,
        "message": responseJson['message']
      };
    } else {
      return {"status": response.statusCode, "message": responseJson['message']};
    }
  }



  static Future<Map<String, dynamic>> payementKelasi(
      Map data, BuildContext context) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://kelasi.trans-academia.cd/api/paiement.php"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? responseData = responseJson['transaction_rf'];
      String? message = responseJson['message'];
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": responseData, "message": message};
    } else if (statusCode == 400) {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getTransactonById(String id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            "https://kelasi.trans-academia.cd/api/paiement.php/transaction?created_by_user_rf=$id"));

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map? responseJson = json.decode(responseBody);
    Map? data = responseJson;

    if (response.statusCode == 200) {
      // print(data);
      return {
        "status": response.statusCode,
        "data": data!['data'],
        "message": data["message"]
      };
    } else {
      return {"status": response.statusCode, "message": data!["message"]};
    }
  }

  static Future<Map<String, dynamic>> activePayment(Map data) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST',
        Uri.parse(
            "https://kelasi.trans-academia.cd/api/paiement.php/callback_AM"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      return {
        "status": statusCode,
        "message": responseJson['message'],
      };
    } else {
      return {"status": statusCode, "message": responseJson['message']};
    }
  }

 

  static Future<Map<String, dynamic>> getEtablissementsKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://kelasi.trans-academia.cd/api/etablissement.php'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getEnfantsDuParent(
      String idParent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse(
          'https://kelasi.trans-academia.cd/api/student.php/parent/$idParent'),
    );
    request.headers.addAll(headers);
    // request.body = json.encode({"Id_parent": "15"});

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      Map<String, dynamic> responseJson = json.decode(responseBody);

      int? statusCode = responseJson['code'];

      if (statusCode == 200) {
        String? message = responseJson['message'];
        Map<String, dynamic>? data = responseJson['data'];
        return {"status": statusCode, "message": message, "data": data};
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> getEnfantsActive(String idParent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse(
          'https://kelasi.trans-academia.cd/api/student.php/parent/$idParent'),
    );
    request.headers.addAll(headers);
    // request.body = json.encode({"Id_parent": "15"});

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      Map<String, dynamic> responseJson = json.decode(responseBody);

      int? statusCode = responseJson['code'];

      if (statusCode == 200) {
        String? message = responseJson['message'];
        Map<String, dynamic>? data = responseJson['data'];
        List? dataActive = data!["active"];
        return {"status": statusCode, "message": message, "data": dataActive};
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> getOperateurKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse("https://kelasi.trans-academia.cd/api/paiement.php/operator"),
    );

    request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List data = responseJson["operator"];
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getSectionKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://kelasi.trans-academia.cd/api/etablissement.php/section'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getOptionKelasi(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://kelasi.trans-academia.cd/api/etablissement.php/section/${id}/option'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message, "data": []};
    }
  }

  static Future<Map<String, dynamic>> getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            "https://kelasi.trans-academia.cd/api/etablissement.php/level"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getProvinceKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse("https://kelasi.trans-academia.cd/api/address.php"));

    request.headers.addAll(headers);
    request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    List<dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List? data = responseJson;
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getVilleKelasi(String idProvince) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse("https://kelasi.trans-academia.cd/api/address.php"));

    request.headers.addAll(headers);
    request.body = json.encode({"province_id": idProvince});

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    List<dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List? data = responseJson;
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getCommuneKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse("https://kelasi.trans-academia.cd/api/address.php/commune"));

    request.headers.addAll(headers);
    // request.body = json.encode({"ville_id": idVille});

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);
    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      List? data = responseJson['data'];
      return {"status": statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

 

 

  static Future<Map<String, dynamic>> getPersonneRefByParent(id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            "https://kelasi.trans-academia.cd/api/parent.php/ref_personne?Id_parent=$id"));

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map? responseJson = json.decode(responseBody);
    List? dataResult = responseJson!['data'];

    if (response.statusCode == 200) {
      // print(data);
      return {
        "status": responseJson['code'],
        "data": dataResult,
        "message": responseJson['message']
      };
    } else {
      return {
        "status": responseJson['code'],
        "message": responseJson['message']
      };
    }
  }

  static Future<Map<String, dynamic>> signupEnfant(Map data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request(
          'POST',
          Uri.parse(
              "https://kelasi.trans-academia.cd/api/student.php/student"));
      request.headers.addAll(headers);
      // print(data);

      request.body = json.encode(data);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(responseBody);

      int statusCode = responseJson['code'];

      if (statusCode == 201) {
        return {
          "status": statusCode,
          "data": responseJson['data'],
          "message": responseJson['message']
        };
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Errefantur interne du serveur"};
    }
  }

   static Future<Map<String, dynamic>> updateEnfant(Map data) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString("token");

      var headers = {
        // 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request(
          'PUT',
          Uri.parse(
              "https://kelasi.trans-academia.cd/api/student.php/Updatestudents"));
      request.headers.addAll(headers);
      // print(data);

      request.body = json.encode(data);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      List <dynamic> responseJson = json.decode(responseBody);
      // Map<String, dynamic> result = json.decode(responseBody);

       int statusCode = responseJson[0]['code'];
       String message = responseJson[0]['message'];

      if (statusCode == 200) {
        
        return {
          "status": statusCode,
          // "data": responseJson[0]['data'],
          "message": message
        };
      } else {
        String message = "Erreur lors de la mise à jour de l'enfant";
        return {"status": response.statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> updateParent(Map data) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString("token");

      var headers = {
        // 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request(
          'PUT',
          Uri.parse(
              "https://kelasi.trans-academia.cd/api/parent.php/update"));
      request.headers.addAll(headers);
      // print(data);

      request.body = json.encode(data);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(responseBody);

      int statusCode = responseJson['code'];

      if (statusCode == 200) {
        return {
          "status": statusCode,
          // "data": responseJson['data'],
          "message": responseJson['message']
        };
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> loginToken(
      String login, String pwd) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('GET',
        Uri.parse("https://kelasi.trans-academia.cd/api/user.php/parent"));

    request.body = json.encode({"login": login, "pwd": pwd});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String token = responseJson['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token.toString());
      return {
        "token": token,
      };
    } else {
      return {"status": statusCode};
    }
  }

  static Future<Map<String, dynamic>> checkOtp(Map data) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://kelasi.trans-academia.cd/api/user.php/otp"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      return {
        "status": statusCode,
        "message": responseJson['message'],
      };
    } else {
      return {"status": statusCode, "message": responseJson['message']};
    }
  }

  static Future<List> getProvincesKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'bearer ${token}'};

    var request = http.Request(
        'GET', Uri.parse('https://kelasi.trans-academia.cd/api/address.php'));
    request.headers.addAll(headers);
    request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];
    List<dynamic> resultList = responseJson.values.toList();

    if (statusCode == 200) {
      return resultList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List> getUniversiteData() async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Etablisement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      return data['donnees'];
    }).catchError((onError) {});
  }

  static Future<List> getFaculteData({required String idUniversite}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Facultes.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idUniversite
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getDepartementData({required String idFaculte}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Departement.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idFaculte
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getPromotionData({required String idDepartement}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_promotion.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idDepartement
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getProvinceData() async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Province.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      return data['donnees'];
    }).catchError((onError) {});
  }

  static Future<List> getVilleData({required String idProvince}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeVille.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      // return data['donnees'];
      return data['donnees']
          .where((e) => e['provinceID'] == idProvince)
          .toList();
    }).catchError((onError) {});
  }

  static Future<List> getVilleDataTac({required String idProvince}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeVille.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);
      // return data['donnees'];
      return data['donnees']
          .where((e) => e['provinceID'] == idProvince)
          .toList();
    }).catchError((onError) {});
  }

  static Future<List> getCommuneData({required String idVille}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeCommune.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      // return data['donnees'];
      return data['donnees'].where((e) => e['IDVILLE'] == idVille).toList();
    }).catchError((onError) {});
  }

  static Future<List> getCommuneDataTac({required String idVille}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeCommune.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      // return data['donnees'];
      return data['donnees'].where((e) => e['IDVILLE'] == idVille).toList();
    }).catchError((onError) {});
  }

  static Future<Map<String, dynamic>> getServicesKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse("https://kelasi.trans-academia.cd/api/dashboard.php/all"),
    );

    request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List data = responseJson["data"];
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getLignesKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse("https://kelasi.trans-academia.cd/api/ligne.php/ligne"),
    );

    request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List data = responseJson["data"];
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getArretsKelasi(idLigne) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'GET',
      Uri.parse(
          "https://kelasi.trans-academia.cd/api/ligne.php/arret?ligne=$idLigne"),
    );

    request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List data = responseJson["data"];
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

   static Future<Map<String, dynamic>> getInfosEncadreur(idLigne) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse("https://kelasi.trans-academia.cd/api/dashboard.php/identity?ligne_id=$idLigne"),
    );

    request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      
      return {"status": response.statusCode, "data": responseJson};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> putArretStudent(
      Map data, String code) async {
    // var headers = {'Content-Type': 'application/json'};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request(
        'PUT',
        Uri.parse(
            "https://kelasi.trans-academia.cd/api/student.php/bus_stop/${code}"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      return {
        "status": statusCode,
        "message": responseJson['message'],
        "data": responseJson['data']
      };
    } else {
      return {"status": statusCode, "message": responseJson['message']};
    }
  }

  //   static Future<List> getCommuneDataTac({required String idVille}) async {
  //   return await http.post(
  //       Uri.parse("${StringFormat.stateInfoUrl}listeCommune.php"),
  //       body: {'App_name': "app", 'token': "2022"}).then((response) {
  //     var data = json.decode(response.body);

  //     // return data['donnees'];
  //     return data['donnees'].where((e) => e['IDVILLE'] == idVille).toList();
  //   }).catchError((onError) {});
  // }

  static Future<Map<String, dynamic>> getNotification(idParent) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse(
          "https://kelasi.trans-academia.cd/api/dashboard.php/notification?parent_id=$idParent"),
    );

    // request.headers.addAll(headers);
    // request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List data = responseJson["data"];
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }
}
