import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final DynamicLinkParameters parameters = DynamicLinkParameters(
  uriPrefix: 'https://abc123.app.goo.gl',
  link: Uri.parse('https://example.com/'),
  androidParameters: AndroidParameters(
    packageName: 'io.devcareer.create_it',
    minimumVersion: 125,
  ),
  iosParameters: IosParameters(
    bundleId: 'com.example.ios',
    minimumVersion: '1.0.1',
    appStoreId: '123456789',
  ),
  googleAnalyticsParameters: GoogleAnalyticsParameters(
    campaign: 'example-promo',
    medium: 'social',
    source: 'orkut',
  ),
  itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
    providerToken: '123456',
    campaignToken: 'example-promo',
  ),
);

void _handleDeepLink(PendingDynamicLinkData data) {
  final Uri deepLink = data.link;
  var isRef = deepLink.pathSegments.contains('invite');
  if (isRef) {
    var refId = deepLink.queryParameters['ref'];
    // if (refId != null) {
    //   changeScreenWithRemove(context, SignUpReferral(refId: refId));
    // }
  }
}

// final Uri dynamicUrl = await parameters.buildUrl();
