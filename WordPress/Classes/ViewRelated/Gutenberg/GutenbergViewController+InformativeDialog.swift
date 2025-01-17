import Foundation

/// This extension handles Alert operations.
extension GutenbergViewController {

    enum InfoDialog {
        static let message = NSLocalizedString(
            "This post uses the block editor, which is the default editor for new posts. To enable the classic editor, go to Me > App Settings.",
            comment: "Popup content about why this post is being opened in block editor"
        )
        static let title = NSLocalizedString("Block Editor Enabled", comment: "Popup title about why this post is being opened in Block Editor")
        static let okButtonTitle   = NSLocalizedString("OK", comment: "OK button to close the informative dialog on Gutenberg editor")
    }

    func showInformativeDialogIfNecessary() {
        if shouldPresentInformativeDialog {
            GutenbergViewController.showInformativeDialog(on: self)
        }
    }

    static func showInformativeDialog(
        on viewController: UIViewControllerTransitioningDelegate & UIViewController,
        animated: Bool = true
    ) {
        let okButton: (title: String, handler: FancyAlertViewController.FancyAlertButtonHandler?) =
        (
            title: InfoDialog.okButtonTitle,
            handler: { (alert, button) in
                alert.dismiss(animated: animated, completion: nil)
            }
        )

        let config = FancyAlertViewController.Config(
            titleText: InfoDialog.title,
            bodyText: InfoDialog.message,
            headerImage: nil,
            dividerPosition: .top,
            defaultButton: okButton,
            cancelButton: nil
        )

        let alert = FancyAlertViewController.controllerWithConfiguration(configuration: config)
        alert.modalPresentationStyle = .custom
        alert.transitioningDelegate = viewController
        viewController.present(alert, animated: animated)
    }
}
