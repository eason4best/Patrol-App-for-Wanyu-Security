import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/model/user_location.dart';

class LocationRequestBanner extends StatelessWidget {
  const LocationRequestBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<UserLocation>(
      builder: (context, userLocation, _) {
        if (!userLocation.hasLocationPermission!) {
          return ListTile(
            tileColor: Colors.white,
            shape: const Border(bottom: BorderSide(color: Colors.black12)),
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            leading: const Icon(
              Icons.warning_outlined,
              color: Colors.red,
            ),
            title: Text(
              '請開啟定位權限',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.red),
            ),
            trailing: const TextButton(
              onPressed: Geolocator.openAppSettings,
              child: Text('開啟'),
            ),
          );
        } else if (!userLocation.locationServiceEnabled!) {
          return ListTile(
            tileColor: Colors.white,
            shape: const Border(bottom: BorderSide(color: Colors.black12)),
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            leading: const Icon(
              Icons.warning_outlined,
              color: Colors.red,
            ),
            title: Text(
              '請開啟手機定位功能',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.red),
            ),
            trailing: const TextButton(
              onPressed: AppSettings.openLocationSettings,
              child: Text('開啟'),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
