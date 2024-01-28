import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecommerce/env/environment.dart';
import 'package:ecommerce/modules/auth/pages/login/login_page.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/models/general_response.dart';
import 'package:ecommerce/shared/models/login_response.dart';
import 'package:ecommerce/shared/providers/functional_provider.dart';
import 'package:ecommerce/shared/secure_storage/user_data_storage.dart';
import 'package:ecommerce/shared/widgets/alerts_template.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class InterceptorHttp {
  Future<GeneralResponse> request(
    BuildContext context,
    String method,
    String endPoint,
    dynamic body, {
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    Function(int sentBytes, int totalBytes)? onProgressLoad,
  }) async {

    var logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis : false));
    final serviceUrl = Environment().config?.serviceUrl ?? 'name app default';

    String url = "$serviceUrl$endPoint?${Uri(queryParameters: queryParameters).query}";

    //logger.t('URL: $url');

    GeneralResponse generalResponse = GeneralResponse(data: null, message: "", error: true);

    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final keyLoading = GlobalHelper.genKey();
    final keyError = GlobalHelper.genKey();

    String? messageButton;
    void Function()? onPress;

    try {
      http.Response _response;
      Uri uri = Uri.parse(url);

      if (showLoading) {
        //debugPrint("KeyLoading del interceptor: $keyLoading");
        fp.showAlertLoading(key: keyLoading, content: const AlertLoading());
       // fp.alertLoading = [const SizedBox()];
        await Future.delayed(const Duration(milliseconds: 600));
      }

      //? Envio de TOKEN
      LoginResponse? userData = await UserDataStorage().getUserData();

      String token = "";
      //String namePatiente = "";
      //bool changePasswrd = false;

      if (userData != null) {
        token = userData.token;
        //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZFNlc2lvbiI6IjIzMmNjNGRlZjEwY2E1YTNmNzQwNzViMWFmOWQzN2IzIiwicGF0aWVudE51bWJlciI6IjIwMDA1ODExIiwiZXhwIjoxNzAzNjA1MzIzLCJpc3MiOiJ0dV9pc3N1ZXIiLCJhdWQiOiJ0dV9hdWRpZW5jZSJ9.d7Q7Tnh94cZbPWCzrC6F_RBEdTT774aezRlo25CPQWQ";
        //userData.tokenSession;
        //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZFNlc2lvbiI6IjFlY2Y4ZGZkMGY3NTljOThlNWI2NGYwZjMzNmE2NmJkIiwicGF0aWVudE51bWJlciI6IjIwMDA1ODExIiwiZXhwIjoxNzAxNDQ5MDYyLCJpc3MiOiJ0dV9pc3N1ZXIiLCJhdWQiOiJ0dV9hdWRpZW5jZSJ9.4ZkoqX4ERZcco-lTQdp89h4T3NgKnOUF5Ks3f8H-Hns"; //userData.tokenSession
        //changePasswrd = userData.cambiarClave;
      }

      //debugPrint("token de sesion: $tokenSesion");
      //debugPrint("nombre paciente: $namePatiente");
      //debugPrint("cambiar contraseña: ${changePasswrd.toString()}");

      //PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Map<String, String> _headers = {
        "Content-Type": "application/json",
        "Authorization": (requestType == 'JSON') ? token : token,
        // "versionName": '${packageInfo.version} ${AppConfig.appEnv.environmentName}',
        // "versionCode": packageInfo.buildNumber
        // "versionName": '1.8.10 DEV',
        // "versionCode": "1"
      };

      int responseStatusCode = 0;
      String responseBody = "";

      
      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              _response = await http.post(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              //inspect(_response);
              break;
            case "GET":
              _response = await http.get(uri, headers: _headers);
              break;
            case "PUT":
              _response = await http.put(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "PATCH":
              _response = await http.patch(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "DELETE":
              _response = await http.delete(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;

            default:
              _response = await http.post(uri, body: jsonEncode(body));
              break;
          }
          responseStatusCode = _response.statusCode;
          responseBody = _response.body;

          //log(json.encode(responseBody.toString()));
          //logger.f(responseBody);
          //Logger(printer: SimplePrinter(colors: true), level: Level.trace).w(json.decode(responseBody));
          //logger.log(Level.trace, json.decode(responseBody));
          logger.log(Level.trace, json.decode(responseBody));


          break;
        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));

          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
          // print("requesMult");
          if (multipartFiles != null) {
            requestMultipart.files.addAll(multipartFiles);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          _headers.forEach((key, value) {
            request.headers.set("Authorization", token);
          });

          debugPrint("TOKEN CARGADO");

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.error = true;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
                // UPLOAD DONE;
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            throw Exception(
                'Error uploading file, Status code: ${httpResponse.statusCode}');
          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
            }
          }
          break;
      }
      
      //logger.t('statusCode: ${responseStatusCode.toString()}');

      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.error = false;
          generalResponse.message = responseDecoded["message"];
          // //final keySesion = GlobalHelper.genKey();
          // if (responseDecoded["error"]) {
          //   // if (responseDecoded["message"] == "No tiene acceso al recurso solicitado") {
          //   //   generalResponse.message ='Su sesión ha caducado, vuelva a iniciar sesión.';
          //   //   debugPrint('entrooo aquiiii porque el token ya cacudo');
          //   //   messageButton = 'Volver a ingresar';
          //   //     onPress = () async {
          //   //       fp.dismissAlert(key: keyError);
          //   //       Navigator.pushReplacement(context, GlobalHelper.navigationFadeIn(context, const LoginPage()));
          //   //       await UserDataStorage().removeUserData();
          //   //       await UserDataStorage().removeUserCredentials();
          //   //     };
          //   //   fp.dismissAlert(key: keyLoading);
          //   //   break;
          //   // }
          //   //debugPrint('HAY ERROR');
          //   generalResponse.error = true;
          //   generalResponse.message = responseDecoded["message"];
          //   fp.dismissAlertLoading(key: keyLoading);
          // } else {
          //   //debugPrint('NO HAY ERROR');
          //   generalResponse.error = false;
          //   generalResponse.message = responseDecoded["message"];
          //   //fp.dismissAlert(key: keyLoading);
          // }
          break;
        case 307:
          generalResponse.error = true;
          generalResponse.message = "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
           fp.dismissAlertLoading(key: keyLoading);
          break;
        case 401:
          generalResponse.message ='Su sesión ha caducado, vuelva a iniciar sesión.';
          generalResponse.error = true;
          messageButton = 'Volver a ingresar';
          // onPress = () async {
          //   fp.clearAllAlert();
          //   Navigator.pushAndRemoveUntil(context, GlobalHelper.navigationFadeIn(context, const LoginPage()), (route) => false);
          //   //Navigator.pushReplacement(context, GlobalHelper.navigationFadeIn(context, const LoginPage()));
          //   await UserDataStorage().removeUserData();
          //   await UserDataStorage().removeUserCredentials();
          //   AlertProfileWidget.patientDataResponse = null;
          //   //fp.dismissAlert(key: LayoutHomeWidget.keyModalProfile);
          // };     
           fp.dismissAlertLoading(key: keyLoading);
          break;
        default:
          generalResponse.error = true;
          generalResponse.message = json.decode(responseBody)["message"];
           fp.dismissAlertLoading(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      debugPrint('$e');
      generalResponse.error = true;
      generalResponse.message = 'Tiempo de conexión excedido.';
       fp.dismissAlertLoading(key: keyLoading);
    } on FormatException catch (ex) {
      //generalResponse.error = true;
      //generalResponse.message = ex.toString();
      debugPrint(ex.toString());
       fp.dismissAlertLoading(key: keyLoading);
    } on SocketException catch (exSock) {
      //logger.e("Error por conexion: $exSock");
      //debugPrint("Error por conexion -> ${exSock.toString()}");
      generalResponse.error = true;
      //generalResponse.message = exSock.toString();
      generalResponse.message = "Verifique su conexión a internet y vuelva a intentar.";
       fp.dismissAlertLoading(key: keyLoading);
    } on Exception catch (e, stacktrace) {
      //logger.e("Error en request: $stacktrace");
      //debugPrint("Error en request -> ${stacktrace.toString()}");
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      fp.dismissAlertLoading(key: keyLoading);
    }

    if (!generalResponse.error) {
      if (showLoading) {
         fp.dismissAlertLoading(key: keyLoading);
        //fp.alertLoading = [];
      }
    } else {
      //debugPrint("Key de error del Interceptor: $keyError");
      fp.showAlert(
        key: keyError,
        content: AlertGeneric(
          content: ErrorGeneric(
            keyToClose: keyError,
            message: generalResponse.message,
            messageButton: messageButton,
            onPress: onPress,
          ),
        ),
      );
    }
    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
      // print(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
