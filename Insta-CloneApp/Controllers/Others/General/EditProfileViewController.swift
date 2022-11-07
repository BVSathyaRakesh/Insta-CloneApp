//
//  EditProfileViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import UIKit

struct EditProfileModel {
    let lable: String
    let placeHolder: String
    var value: String?
}



final class EditProfileViewController: UIViewController,UITableViewDataSource {
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identfier)
       return tableView
    }()
    
    private var models = [[EditProfileModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureModels(){
        //name,username, website,bio
        let sectionLabels = ["Name","UserName","Bio"]
        var section1 = [EditProfileModel]()
        for label in sectionLabels {
            let model = EditProfileModel(lable: label, placeHolder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        
        //email, phone, gender
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileModel]()
        for label in section2Labels {
            let model = EditProfileModel(lable: label, placeHolder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        
        models.append(section1)
        models.append(section2)
        
    }
    
    //Mark: - TableView
    func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/4.0).integral)
        let size = header.height/1.5
        let profileButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                   y: (header.height-size)/2,
                                                   width: size,
                                                   height: size))
        profileButton.tintColor = .label
        profileButton.layer.masksToBounds = true
        profileButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profileButton.layer.borderWidth = 1.0
        profileButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        header.addSubview(profileButton)
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identfier, for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private Information"
    }
    

    @objc func didTapSave(){
        //Save info to database
    }
    
    @objc func didTapCancel(){
       
    }
    
    func didTapChangeProfilePicture() {
        let alert =  UIAlertController(title: "Profile Picture", message: "Change Profile Picture?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default,handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
        
        }))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .cancel, handler: nil))
        
        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.bounds
        self.present(alert, animated: false)
    }

}

extension EditProfileViewController : FormTableViewCellDelegate {

    func formTableviewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileModel?) {
        //update to model
        print(updatedModel?.value ?? "nil")
        print(updatedModel?.placeHolder ?? "nil")
        print(updatedModel?.lable ?? "nil")
    }
  
}
