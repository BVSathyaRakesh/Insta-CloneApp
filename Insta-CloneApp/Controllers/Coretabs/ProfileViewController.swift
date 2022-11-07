//
//  ProfileViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import UIKit

///Profile View Controller
final class ProfileViewController: UIViewController {
    
    private var collectionsView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 0)
        let size = (view.width-4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionsView?.backgroundColor = .red
        collectionsView?.delegate = self
        collectionsView?.dataSource = self
        
        // Cell
        collectionsView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        //Headers
        collectionsView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionsView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        guard let collectionView = collectionsView  else {
            return
        }

        view.addSubview(collectionView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        collectionsView?.frame = view.bounds
    }
    
   private func configureNavigationBar(){
       navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapSettings))
    }
    
    @objc func didTapSettings() {
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ProfileViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .systemBlue
        return cell
    }
        
}
