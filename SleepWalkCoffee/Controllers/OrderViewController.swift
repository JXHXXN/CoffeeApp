//
//  OrderViewController.swift
//  SleepWalkCoffee
//
//  Created by 황지현 on 2023/01/20.
//

import UIKit
import SquareInAppPaymentsSDK

protocol OrderViewControllerDelegate: AnyObject {
    func didRequestPayWithCard()
}

class OrderViewController : UIViewController {
    weak var delegate: OrderViewControllerDelegate?
    override func loadView() {
        let orderView = OrderView()
        self.view = orderView

        orderView.addCardButton.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
        orderView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPayButton() {
        delegate?.didRequestPayWithCard()
    }
}

extension OrderViewController: HalfSheetPresentationControllerHeightProtocol {
    var halfsheetHeight: CGFloat {
        return (view as! OrderView).stackView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
}

class OrderNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarHidden(true, animated: false)
    }
}

extension OrderNavigationController: HalfSheetPresentationControllerHeightProtocol {
    var halfsheetHeight: CGFloat {
        return ((viewControllers.last as? HalfSheetPresentationControllerHeightProtocol)?.halfsheetHeight ?? 0.0) + navigationBar.bounds.height
    }
}