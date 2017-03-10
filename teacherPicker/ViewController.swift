//
//  ViewController.swift
//  teacherPicker
//
//  Created by Rohan Lokesh Sharma on 09/03/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var info = ["Name","Room no.","Class"]
    var buildings = ["TP","UB"]
    var floors  = [1,2,3,4,5,6,7,8,9,10]
    var rooms = [1,2,3,4,5,6,7,8,9,10]
    
   lazy var myTableView:UITableView = {
    let view = UITableView()
    view.translatesAutoresizingMaskIntoConstraints = false;
    view.dataSource = self;
    view.delegate = self;
    view.isScrollEnabled = false;
    
    return view;
    
    }()

     var container:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = .white;
        return view;
    }()
    
    lazy var picker:UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.dataSource = self;
        view.delegate = self;
        return view;
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Teacher Picker"
        setupViews()
  
        super.viewDidLoad()

    }
    
    func setupViews(){
        
        
        view.addSubview(container)
        view.addSubview(myTableView)
        container.addSubview(picker)
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false;
        seperator.backgroundColor = .lightGray
        container.addSubview(seperator)
        let cons = [ container.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                     container.leftAnchor.constraint(equalTo: view.leftAnchor),
                     container.rightAnchor.constraint(equalTo: view.rightAnchor),
                     container.heightAnchor.constraint(equalToConstant:220),
            
            
                    myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                    myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    myTableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                    myTableView.topAnchor.constraint(equalTo: container.bottomAnchor),
                    
                    picker.leftAnchor.constraint(equalTo: container.leftAnchor),
                    picker.rightAnchor.constraint(equalTo: container.rightAnchor),
                    picker.topAnchor.constraint(equalTo: container.topAnchor),
                    picker.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                    
                    seperator.leftAnchor.constraint(equalTo: container.leftAnchor),
                    seperator.rightAnchor.constraint(equalTo: container.rightAnchor),
                    seperator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                    seperator.heightAnchor.constraint(equalToConstant: 0.5)
                    
                     ]
        
        for i in cons {
            i.isActive = true;
        }
        
        
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return info.count
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = info[indexPath.row]
            if indexPath.row == 1{
                let floor = picker.selectedRow(inComponent: 1)
                let room = picker.selectedRow(inComponent: 2)
                cell.detailTextLabel?.text = "\(floors[floor] * 100 + rooms[room])"
                
            }
            else{
                cell.detailTextLabel?.text = "testing"
            }
            return cell
        }
        else{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell1")
            cell.textLabel?.text = "Contact Teacher"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            return cell
        }
        
        
      //  return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1){
            return 40
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      /*  if(section == 1){
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
            return view
        }*/
        return nil
        
    }
}

extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return buildings.count
        case 1:
            return floors.count
        default:
            return rooms.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return buildings[row]
        case 1:
            return "\(floors[row])"
        default:
            let sel = picker.selectedRow(inComponent: 1)
            return "\(floors[sel] * 100 + rooms[row])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 1){
            picker.reloadComponent(2)
            myTableView.reloadData()
        }
        if component == 2{
            myTableView.reloadData()
        }
    }
}
