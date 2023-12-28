import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:splitbuddy/constants/request_headers.dart';
import 'package:splitbuddy/constants/server_constants.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/providers/country_provider.dart';

class CountryService {
  void getAllCountryCodes(context) async {
    try {
      var countryProvider =
          Provider.of<CountryProvider>(context, listen: false);
      http.Response response = await http.get(
          Uri.parse(ServerConstants.getAllCountriesUrl),
          headers: RequestHeaders.getUnAuthenticatedHeaders());

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            countryProvider.addAllCountries(response.body);
          });
    } catch (e) {
      showSnackbar(
          context, "Could not process request. Please try again later");
    }
  }
}
