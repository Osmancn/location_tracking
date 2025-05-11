import UIKit
import Flutter
import GoogleMaps
import background_location_tracker

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDR8hSK5AYcXLi_4UBWP3_0kayvwbFEGk4")
    GeneratedPluginRegistrant.register(with: self)
    BackgroundLocationTrackerPlugin.setPluginRegistrantCallback { registry in
                GeneratedPluginRegistrant.register(with: registry)
            }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}