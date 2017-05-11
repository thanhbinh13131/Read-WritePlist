//
//  ViewController.swift
//  DemoPlist_ttb
//
//  Created by TTB on 5/11/17.
//  Copyright © 2017 TTB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let item: String = "Item"
    var itemValue: String?
    @IBOutlet weak var itemLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addData(_ sender: Any) {
        self.savedata(value: itemLabel.text!)
    }
    func savedata(value:String){
        let paths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("data.plist")
        let dict: NSMutableDictionary = [:]
        dict.setObject(value, forKey: item as NSString)
        dict.write(toFile: path, atomically: false)
    }
    func getData() {
        let paths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("data.plist")
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "data", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                    
                }catch{
                    print("failure")
                }
            }else{
                print("file not found")
            }
        }else{
            print("file already exists!")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("My list: ->\(resultDictionary?.description)")
        let dicts = NSDictionary(contentsOfFile: path)
        if let dic = dicts {
            itemValue = dic.object(forKey: item) as! String
            itemLabel.text = itemValue
        }
    }

}

