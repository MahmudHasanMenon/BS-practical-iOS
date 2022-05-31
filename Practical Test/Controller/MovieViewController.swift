//
//  MovieViewController.swift
//  Practical Test
//
//  Created by localadmin on 31/5/2022.
//

import UIKit
import Foundation

class MovieViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movieViewModel: MovieViewModel?
    var activityIndicator: UIActivityIndicatorView!

    
    var movieLists: [MovieData] = []
    var apiMovieLists: [MovieData] = []
    var queryText: String = "Marvel"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelpers()
        initActivityIndicator()

        loadMovieList()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: "MoviewTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "Cell")
        
        self.navigationItem.titleView = navTitleWithImageAndText(titleText: "Movie List")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movie List"
       
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Commons.colorWithHexString(Colors.NAV_BAR_COLOR)
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        } else {
            if #available(iOS 13.0, *) {
                self.navigationController?.navigationBar.barTintColor = Commons.colorWithHexString(Colors.NAV_BAR_COLOR)
            } else {
                // Fallback on earlier versions
            }
            self.navigationController?.navigationBar.tintColor = .white
        };
         
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.isTranslucent = false
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = Commons.colorWithHexString(Colors.NAV_BAR_COLOR)
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = Commons.colorWithHexString(Colors.NAV_BAR_COLOR)
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func initHelpers() {
        movieViewModel = MovieViewModel(self.view)
    }
    
    private func initActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = Commons.initProgressHUD(self.view)
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(activityIndicator)
    }
    
    private func showActivityIndicator(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func navTitleWithImageAndText(titleText: String) -> UIView {

        // Creates a new UIView
        let titleView = UIView()

        // Creates a new text label
        let label = UILabel()
        label.text = titleText
        label.sizeToFit()
        label.textColor = UIColor.white
        label.center = titleView.center
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = NSTextAlignment.center

        // Adds both the label and image view to the titleView
        titleView.addSubview(label)
//        titleView.addSubview(image)

        // Sets the titleView frame to fit within the UINavigation Title
        titleView.sizeToFit()

        return titleView

    }
    
    func loadMovieList() {
//        self.showActivityIndicator(true)
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        dispatchQueue.async {
            self.movieViewModel?.getMoviewLists(queryText: self.queryText, _completion: { isSuccess in
//                self.showActivityIndicator(false)
                //                    self.dataLoadedYet = true
                self.movieLists = []
//                self.showActivityIndicator(false)
                guard let movieLists = self.movieViewModel?.movieArray else {return}
                self.movieLists = movieLists
                self.apiMovieLists = movieLists
                if isSuccess {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else {
//                    self.showActivityIndicator(false)
                     
                }
            })
        }
    }
    
    func loadSearchMovieList() {
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        dispatchQueue.async {
            self.movieViewModel?.getSearchMoviewLists(queryText: self.queryText, _completion: { isSuccess in
//                self.showActivityIndicator(false)
                //                    self.dataLoadedYet = true
                self.movieLists = []
                guard let movieLists = self.movieViewModel?.searchMovieArray else {return}
                self.movieLists = movieLists
                if isSuccess {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else {
//                    self.showActivityIndicator(false)
                     
                }
            })
        }
    }
    

}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            if self.movieLists.count > 0 {
                self.tableView.backgroundView = nil
                tableView.restore()
                return self.movieLists.count
            }
        else {
            
            tableView.setEmptyView(title: "Oopps!.", message: "No movie found!")

        }
          return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.movieLists.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoviewTableViewCell
//            cell.configureTableData(data: self.CartProducts[indexPath.row])
            cell.title.text = self.movieLists[indexPath.row].title
            cell.movieDescription.text = self.movieLists[indexPath.row].overview
            let poster_path = self.movieLists[indexPath.row].bannerPath
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster_path)")

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.BannerImage.image = UIImage(data: data!)
                }
            }
            
            return cell
        }
        
         return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            self.queryText = searchText
            self.loadSearchMovieList()
        }
        else {
            self.queryText = "Marvel"
            self.movieLists = self.apiMovieLists
            self.tableView.reloadData()
        }
    }
}
