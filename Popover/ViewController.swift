//
//  ViewController.swift
//  Popover
//
//  Created by юра on 13.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    var popVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Present", for: .normal)
        setup()
    }
    
    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        gesture.numberOfTapsRequired = 1
        button.addGestureRecognizer(gesture)
    }
    
    @objc func tapped() {
        
        popVC = storyboard?.instantiateViewController(withIdentifier: "popVC")
        popVC?.modalPresentationStyle = .popover
        
        let popOver = popVC?.popoverPresentationController
        popOver?.delegate = self
        
        popOver?.sourceView = button
        popOver?.sourceRect = CGRect(x: button.bounds.midX, y: button.bounds.maxY - 30, width: 0, height: 0)
        
        let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        popVC?.navigationItem.titleView = segmentedControl
        segmentedControl.frame = CGRect(x: popVC!.view.bounds.midX / 2 - 4, y: popVC!.view.frame.minY + 20, width: 100, height: 30)
        
        let closeButton = UIButton(type: .system)
        let image = UIImage(systemName: "multiply.circle.fill")
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = .red
        closeButton.addTarget(self, action: #selector(closePopover), for: .touchUpInside)
        closeButton.frame = CGRect(x: popVC!.view.bounds.midX + 40, y: popVC!.view.frame.minY + 10, width: 50, height: 50)
        
        popVC?.preferredContentSize = CGSize(width: 300, height: 280)
        present(popVC!, animated: true)
        popVC?.view.addSubview(segmentedControl)
        popVC?.view.addSubview(closeButton)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        var height: CGFloat = 0
        switch sender.selectedSegmentIndex {
        case 0:
            height = 280
        case 1:
            height = 150
        default:
            break
        }
        popVC?.preferredContentSize = CGSize(width: 300, height: height)
    }
    
    @objc func closePopover() {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
