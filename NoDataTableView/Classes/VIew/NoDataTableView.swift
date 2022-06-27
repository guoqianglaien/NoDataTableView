//
//  NoDataTableView.swift
//  NoDataTableView
//
//  Created by guoqiang on 2022/6/23.
//

import UIKit
import SnapKit

public enum TableViewNoDataViewType {
    case workoutHistory
    case myRecent
    case searchNoData
    case noFav
    case noDownload
    
    var title: String {
        get {
            switch self {
            case .workoutHistory, .myRecent: return "No History Yet"
            case .searchNoData: return "No Results"
            case .noFav: return "No Favorites Yet"
            case .noDownload: return "No Downloads Yet"
            }
        }
    }
    
    var content: String {
        get {
            switch self {
            case .workoutHistory, .myRecent: return "Your workout history will show here after you complete your first workout"
            case .searchNoData: return "for\" \""
            case .noFav: return "Heart your favorite workouts to save them here for quick access"
            case .noDownload: return "Download your workouts to access them here when you are offline"
            }
        }
    }
    
    var image: String {
        get {
            switch self {
            case .workoutHistory, .myRecent: return "nodata_workout_history"
            case .searchNoData: return "playlist_no_result"
            case .noFav: return "favorite_nodata"
            case .noDownload: return "no_download"
            }
        }
    }
}

public class NoDataTableView: UIView {
    
    private let contentLB = UILabel(frame: .zero, text: "", textColor: .black, font: .systemFont(ofSize: 17), textAligment: .center)
    private let titleLB = UILabel(frame: .zero, text: "", textColor: .lightGray, font: .systemFont(ofSize: 15), textAligment: .center)

    private let imageView = UIImageView()

    
    public init(frame: CGRect, type: TableViewNoDataViewType) {
        super.init(frame: frame)
        
        createUI(type)
    }
    
    func createUI(_ type: TableViewNoDataViewType) {
        imageView.image = UIImage(named: type.image)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
        }
        titleLB.text = type.title
        titleLB.numberOfLines = 0
        addSubview(titleLB)
        titleLB.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(23)
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
        contentLB.text = type.content
        contentLB.numberOfLines = 0
        addSubview(contentLB)
        contentLB.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLB.snp.bottom).offset(8)
        }
    }
    
    func refreshType(_ type: TableViewNoDataViewType) {
        imageView.image = UIImage(named: type.image)
        titleLB.text = type.title
        titleLB.text = type.content
    }
    
    func refreshContentLB(_ text: String) {
        contentLB.text = text
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UILabel {
    
    convenience init(frame: CGRect, text: String?, textColor:  UIColor, font: UIFont, textAligment: NSTextAlignment? = .left) {
        self.init(frame: frame)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAligment ?? .left
    }
}

