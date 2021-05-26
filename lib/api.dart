import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

Future Getdata(url) async {
  http.Response Response = await http.get(url);
  var res = parse(Response.body);
  return res;
}
