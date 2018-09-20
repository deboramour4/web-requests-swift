//
//  ViewController.swift
//  WebRequestsTest
//
//  Created by Ada 2018 on 20/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class Ex2ViewController: UIViewController {
    
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var charLabel: UILabel!
    @IBOutlet var numberCharLabel: UILabel!
    @IBOutlet var jsonTextView: UITextView!
    
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
    
    func doDownloadWebPage(url getURL: URL = URL(string: "https://ios-twitter.herokuapp.com/api/v1/message")!) {
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: getRequest) {
            (data, response, error) in
            
            if data != nil {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    DispatchQueue.main.async {
                        self.jsonTextView.text = ("\(resultObject)")
                        //print("Results from GET \(getRequest) :\n \(resultObject)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Unable to parse JSON response in \(getRequest)")
                    }
                }
            } else {
                print("Received empty quest response from \(getRequest)")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
    
}

