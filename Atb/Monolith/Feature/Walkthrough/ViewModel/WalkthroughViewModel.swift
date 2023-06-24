import Foundation
import CoreLocation
import AppTrackingTransparency

enum WalkthroughStep {
  case welcomeStep
  case appTrackingTransparencyStep
  case locationPermissionStep
  case enjoyStep
}

class WalkthroughViewModel {

  var currentStep: WalkthroughStep = .welcomeStep
  let locationManager = CLLocationManager()

  func getNextStep() {
    switch currentStep {
    case .welcomeStep:
      currentStep = .appTrackingTransparencyStep
    case .appTrackingTransparencyStep:
      currentStep = .locationPermissionStep
    case .locationPermissionStep:
      currentStep = .enjoyStep
    case .enjoyStep:
      // Handle completion of the walkthrough
      break
    }
  }

  func performStepAction() {
    switch currentStep {
    case .welcomeStep:
      // Perform action for the app description step
      break
    case .appTrackingTransparencyStep:
      requestAppTrackingPermission()
    case .locationPermissionStep:
      requestLocationPermission()
    case .enjoyStep:
      // Perform action for the goodbye step
      break
    }
  }
}

// MARK: Private methods
extension WalkthroughViewModel {

  private func requestLocationPermission() {
    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()

    case .authorizedAlways, .authorizedWhenInUse, .restricted, .denied:
      navigateToNextStep()

    @unknown default:
      break
    }
  }

  private func navigateToNextStep() {
    DispatchQueue.main.async {
      self.getNextStep()
      // Perform any necessary UI updates here
    }
  }

  private func requestAppTrackingPermission() {
    ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
  }
}
