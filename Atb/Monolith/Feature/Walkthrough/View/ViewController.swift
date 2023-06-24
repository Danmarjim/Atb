import UIKit

class ViewController: UIViewController {
  
  let stepLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 24)
    return label
  }()

  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Next", for: .normal)
    button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    return button
  }()

  var viewModel = WalkthroughViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    updateUI()
  }

  func setupUI() {
    view.backgroundColor = .white
    view.addSubview(stepLabel)
    view.addSubview(nextButton)

    NSLayoutConstraint.activate([
      stepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stepLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      nextButton.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 20),
      nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }

  func updateUI() {
    switch viewModel.currentStep {
    case .welcomeStep:
      stepLabel.text = "Step 1: App Description"
    case .appTrackingTransparencyStep:
      stepLabel.text = "Step 2: App Tracking Transparency"
    case .locationPermissionStep:
      stepLabel.text = "Step 3: Location Permission"
    case .enjoyStep:
      stepLabel.text = "Step 4: Goodbye and Enjoy the App!"
    }

    UIView.transition(with: stepLabel, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
  }

  @objc func nextButtonTapped() {
    viewModel.performStepAction()

    if viewModel.currentStep == .enjoyStep {
      navigateToMainApp()
    } else {
      viewModel.getNextStep()
      updateUI()
    }
  }

  func navigateToMainApp() {
    let mainVC = HomeViewController()
    mainVC.modalPresentationStyle = .fullScreen
    present(mainVC, animated: true, completion: nil)
  }
}
