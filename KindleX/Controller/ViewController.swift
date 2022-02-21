//
//  ViewController.swift
//  KindleX
//
//  Created by Valeriy Fomin on 15/2/22.
//

import UIKit


class ViewController: UITableViewController {

    //MARK: - Properties
    var books: [Book]? = []

    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarStyles()
        setupNavBarButtons()

        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -35, right: 0)
        navigationItem.title = "Kindle"
        fetchBooks()
    }

    //MARK: - Methods

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)

        let segmentcontrol = UISegmentedControl(items: ["Cloud", "Device"])
        segmentcontrol.tintColor = UIColor.white
        segmentcontrol.selectedSegmentIndex = 0
        segmentcontrol.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(segmentcontrol)
        segmentcontrol.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentcontrol.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentcontrol.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentcontrol.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        let gridButton = UIButton(type: .system)
        gridButton.setImage(UIImage(systemName: "square.grid.3x3")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)

        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 20).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        let sortButton = UIButton(type: .system)
        sortButton.setImage(UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)

        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -20).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }

    func setupNavBarButtons() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bag")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleBuyIconPress))
           }

    @objc func handleMenuPress() {
        print("Menu pressed")
    }

    @objc func handleBuyIconPress() {
        print("Buy pressed")
    }

    func setupNavigationBarStyles() {

        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func fetchBooks() {
        print("Fetching books...")
        guard let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let err = error {
                print("Failed to fetch external json books", err)
                return
            }

            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let bookDictionaries = json as? [[String: Any]] else { return }

                for bookDictionary in bookDictionaries {

                    let book = Book(dictionary: bookDictionary)
                    self.books?.append(book)
                }

                print("All of our books: ", self.books as Any)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }


            } catch let jsonError {
                print("Failed to parse JSON properly: ", jsonError)
            }


        }.resume()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedBook = self.books?[indexPath.row]

        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageViewController(collectionViewLayout: layout)

        bookPageController.book = selectedBook
        let navController = UINavigationController(rootViewController: bookPageController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell

        let book = books?[indexPath.row]
        cell.book = book
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
}



