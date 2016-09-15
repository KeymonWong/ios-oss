import XCTest
@testable import Kickstarter_Framework
@testable import Library
import KsApi
import Prelude

internal final class DiscoveryFiltersDataSourceTests: XCTestCase {
  private let collectionsHeader = DiscoveryFiltersDataSource.Section.collectionsHeader.rawValue
  private let collections = DiscoveryFiltersDataSource.Section.collections.rawValue
  private let categoriesHeader = DiscoveryFiltersDataSource.Section.categoriesHeader.rawValue
  private let categories = DiscoveryFiltersDataSource.Section.categories.rawValue
  private let favoritesHeader = DiscoveryFiltersDataSource.Section.favoritesHeader.rawValue
  private let favorites = DiscoveryFiltersDataSource.Section.favorites.rawValue

  private let dataSource = DiscoveryFiltersDataSource()
  private let tableView = UITableView()

  func testLoadTopRows() {
    self.dataSource.load(topRows: [
                                    SelectableRow(isSelected: false, params: .defaults),
                                    SelectableRow(isSelected: false, params: .defaults),
                                    SelectableRow(isSelected: false, params: .defaults),
                                    SelectableRow(isSelected: false, params: .defaults)
                                  ],
                         categoryId: nil
    )

    XCTAssertEqual(4, self.dataSource.tableView(self.tableView, numberOfRowsInSection: collections))
    XCTAssertEqual("DiscoverySelectableRowCell", self.dataSource.reusableId(item: 0, section: collections))
    XCTAssertEqual(1, self.dataSource.tableView(self.tableView, numberOfRowsInSection: collectionsHeader))
    XCTAssertEqual("DiscoveryFiltersStaticRowCell",
                   self.dataSource.reusableId(item: 0, section: collectionsHeader))
  }

  func testLoadFavoriteRows() {
    self.dataSource.load(favoriteRows: [
      SelectableRow(isSelected: false, params: .defaults),
      SelectableRow(isSelected: false, params: .defaults),
      SelectableRow(isSelected: false, params: .defaults),
      SelectableRow(isSelected: false, params: .defaults)
      ],
                         categoryId: nil
    )

    XCTAssertEqual(4, self.dataSource.tableView(self.tableView, numberOfRowsInSection: favorites))
    XCTAssertEqual("DiscoverySelectableRowCell", self.dataSource.reusableId(item: 0, section: favorites))
    XCTAssertEqual(1, self.dataSource.tableView(self.tableView, numberOfRowsInSection: favoritesHeader))
    XCTAssertEqual("DiscoveryFiltersStaticRowCell",
                   self.dataSource.reusableId(item: 0, section: favoritesHeader))
  }

  func testLoadCategories() {
    self.dataSource.load(categoryRows: [
                          ExpandableRow(
                            isExpanded: false,
                            params: .defaults,
                            selectableRows: [
                              SelectableRow(isSelected: false, params: .defaults),
                              SelectableRow(isSelected: false, params: .defaults)
                            ]
                          ),
                          ExpandableRow(
                            isExpanded: false,
                            params: .defaults,
                            selectableRows: [
                              SelectableRow(isSelected: false, params: .defaults),
                              SelectableRow(isSelected: false, params: .defaults)
                            ]
                          )
                          ],
                         categoryId: nil)

    XCTAssertEqual(2, self.dataSource.tableView(self.tableView, numberOfRowsInSection: categories))
    XCTAssertEqual("DiscoveryExpandableRowCell", self.dataSource.reusableId(item: 0, section: categories))
    XCTAssertEqual("DiscoveryExpandableRowCell", self.dataSource.reusableId(item: 1, section: categories))
    XCTAssertEqual(1, self.dataSource.tableView(self.tableView, numberOfRowsInSection: categoriesHeader))
  }

  func testLoadCategoriesWithExpansion() {
    self.dataSource.load(categoryRows: [
                          ExpandableRow(
                            isExpanded: false,
                            params: .defaults,
                            selectableRows: [
                              SelectableRow(isSelected: false, params: .defaults),
                              SelectableRow(isSelected: false, params: .defaults)
                            ]
                          ),
                          ExpandableRow(
                            isExpanded: true,
                            params: .defaults,
                            selectableRows: [
                              SelectableRow(isSelected: false, params: .defaults),
                              SelectableRow(isSelected: false, params: .defaults)
                            ]
                          )
                          ],
                         categoryId: nil)

    XCTAssertEqual(4, self.dataSource.tableView(self.tableView, numberOfRowsInSection: categories))
    XCTAssertEqual("DiscoveryExpandableRowCell", self.dataSource.reusableId(item: 0, section: categories))
    XCTAssertEqual("DiscoveryExpandableRowCell", self.dataSource.reusableId(item: 1, section: categories))
    XCTAssertEqual("DiscoveryExpandedSelectableRowCell",
                   self.dataSource.reusableId(item: 2, section: categories))
    XCTAssertEqual("DiscoveryExpandedSelectableRowCell",
                   self.dataSource.reusableId(item: 3, section: categories))
  }
}
