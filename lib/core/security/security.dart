import 'dart:io';

// Use certificate / SSL
// Future<HttpClient> getHttpClient() async {
//   final sslCert = await rootBundle.load('certificate/certificate.pem');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   HttpClient httpClient = HttpClient(context: securityContext);
//   httpClient.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => false;

//   return httpClient;
// }

Future<HttpClient> getHttpClient() async {
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  HttpClient httpClient = HttpClient(context: securityContext);
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;

  return httpClient;
}
