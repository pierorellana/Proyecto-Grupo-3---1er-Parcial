class RoutesApi {
  //servidor de produccion
  //static const String baseurl = 'https://wtzwcrwyrldnxdocdgwg.supabase.co/';

  //servidor de desarrollo
  static const String baseurl = 'http://192.168.100.92:8000/';

  static const String apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0endjcnd5cmxkbnhkb2NkZ3dnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODc5NzcwMzQsImV4cCI6MjAwMzU1MzAzNH0.an-OubvX0r8ncCGZGvpd4_V7hxVdKI9WASYoPvWA4i8';

  static const String apikeyAuthorization =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0endjcnd5cmxkbnhkb2NkZ3dnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4Nzk3NzAzNCwiZXhwIjoyMDAzNTUzMDM0fQ.QN_cHldS4Mh17HioUe9ayGf6Vzw921WgJoJShTujo04";

  static const String authorization =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0endjcnd5cmxkbnhkb2NkZ3dnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4Nzk3NzAzNCwiZXhwIjoyMDAzNTUzMDM0fQ.QN_cHldS4Mh17HioUe9ayGf6Vzw921WgJoJShTujo04";

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'apikey': apikey,
  };

  static const Map<String, String> headersAuthorization = {
    'Content-Type': 'application/json',
    'apikey': apikeyAuthorization,
    'Authorization': authorization,
  };
}
