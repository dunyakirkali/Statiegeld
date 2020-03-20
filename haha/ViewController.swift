//
//  ViewController.swift
//  haha
//
//  Created by Dunya Kirkali on 02/04/2018.
//  Copyright © 2018 Ahtung. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generate() {
        view.endEditing(true)

        guard let text = input.text else {
            return
        }
        let result: String = text + calculateChecksum(str: text)

        let image = RSUnifiedCodeGenerator.shared.generateCode(result, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        imageView.image = image
    }

    func calculateChecksum(str: String) -> String {
        let odd = str.characters.map {
            Int(String($0))!
        }.enumerated().filter { (index, element) in
            index % 2 == 0
        }.map { $1 }.reduce(0, +)

        let even = str.characters.map {
            Int(String($0))!
        }.enumerated().filter { (index, element) in
            index % 2 == 1
        }.map { $1 }.reduce(0, +)


        return String(10 - (((even * 3) + odd) % 10))
    }
}
