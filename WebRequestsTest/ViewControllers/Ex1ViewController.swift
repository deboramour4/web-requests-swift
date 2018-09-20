//
//  ViewController.swift
//  WebRequestsTest
//
//  Created by Ada 2018 on 20/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class Ex1ViewController: UIViewController {

    @IBOutlet var numberCharLabel: UILabel!
    @IBOutlet var charLabel: UILabel!
    @IBOutlet var htmlTextView: UITextView!
    @IBOutlet var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func requestAction(_ sender: Any) {
        if urlTextField.text == "" || urlTextField.text == "https://" {
            doDownloadWebPage()
        } else {
            doDownloadWebPage(url: URL(string: urlTextField.text!)!)
        }
        charLabel.text = "Caracteres obitidos:"
    }
    
    func doDownloadWebPage(url httpURL: URL = URL(string: "https://www.ifce.edu.br")!) {
        let httpTask = URLSession.shared.dataTask(with: httpURL) {
            (data, response, error) in
            
            guard let validData = data, error == nil else {
                print("Deu ruim")
                return
            }
            
            let results = String(data: validData, encoding: String.Encoding.utf8) ?? "Erro decodificando"
            
            DispatchQueue.main.async {
                self.numberCharLabel.text = String(results.count)
                self.htmlTextView.text = results
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            httpTask.resume()
        }
    }
    
}

