//
//  PagesTableViewController.swift
//  BRGamebookEngine
//
//  Created by Brad Root on 8/20/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import UIKit

protocol PagesTableViewDelegate: AnyObject {
    func selectedPage(_ page: Page)
    func deletedPage(_ page: Page)
}

class PagesTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var pagesSearchBar: UISearchBar!
    var game: Game
    var pages: [Page] = []
    weak var delegate: PagesTableViewDelegate?

    // MARK: Initialization

    init(for game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pages"

        tableView.register(UINib(nibName: "PageTableViewCell", bundle: nil), forCellReuseIdentifier: "pageCell")

        pagesSearchBar.delegate = self

        loadPages()
    }

    // MARK: Load Content

    fileprivate func loadPages() {
        pages = game.pages?.array as? [Page] ?? []
        tableView.reloadData()
    }

    // MARK: Table View

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return pages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath) as? PageTableViewCell,
            let page = pages.item(at: indexPath.row) else { fatalError() }

        cell.page = page

        return cell
    }

    override func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let page = pages.item(at: indexPath.row) else { return }
        delegate?.selectedPage(page)
        navigationController?.popViewController(animated: true)
    }

    // MARK: Scroll View

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pagesSearchBar.endEditing(true)
    }

    // MARK: Search Bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Leaves the method if the entered text is empty
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            loadPages()
            return
        }

        GameDatabase.standard.searchPages(for: game, terms: searchText) { [weak self] pages in
            self?.pages = pages
            self?.tableView.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pagesSearchBar.endEditing(true)
    }
}
