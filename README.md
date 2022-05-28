# SideMenuKitSwiftUI

SideMenuKitSwiftUI is a framework for displaying menus on the left side of the screen. Two types of menu styles are provided: sliding menu and sidebar menu. A sliding menu is a menu with a title and an icon. Sidebar menu is a menu with only icons.

![Slide Menu](SlideMenu.png "Slide Menu")

![Sidebar Menu](SidebarMenu.png "Sidebar Menu")

You can add this package on Xcode.
See [documentation](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).


## How to Use

You can just import SideMenuKitSwiftUI to use the package.

```swift
import SwiftUI
import SideMenuKitSwiftUI

struct ContentView: View
{
  enum Menu: Int, Hashable
  {
    case fine
    case cloudy
    case rainy
    case snow
    case bolt
    case wind
    case tornado
  }

  private let items: [SideMenuItem<Menu>] = [
    (title: "Fine",    icon: "sun.max.fill",  tag: Menu.fine,    color: Color.orange),
    (title: "Cloudy",  icon: "cloud.fill",    tag: Menu.cloudy,  color: Color.gray),
    (title: "Rainy",   icon: "umbrella.fill", tag: Menu.rainy,   color: Color.blue),
    (title: "Snow",    icon: "snowflake",     tag: Menu.snow,    color: Color.cyan),
    (title: "Bolt",    icon: "bolt.fill",     tag: Menu.bolt,    color: Color.yellow),
    (title: "Wind",    icon: "wind",          tag: Menu.wind,    color: Color.green),
    (title: "Tornado", icon: "tornado",       tag: Menu.tornado, color: Color.indigo)
  ].map({ SideMenuItem<Menu>(title: $0.title, icon: $0.icon, tag: $0.tag, color: $0.color) })

  private let configuration: SideMenuConfiguration = .slide

  var body: some View {
    SideMenu<Menu,MenuContentView>(configuration: configuration, menuItems: items, startItem: .fine) {
      (menu) -> MenuContentView in
      MenuContentView(selected: menu, items: items)
    }
  }

  struct MenuContentView: View
  {
    private let menu: Menu
    private let item: SideMenuItem<Menu>

    init(selected menu: Menu, items: [SideMenuItem<Menu>]) {
      self.menu = menu
      self.item = items.filter({ $0.tag == menu })[0]
    }

    @ViewBuilder
    var body: some View {
      VStack {
        item.icon.resizable()
          .aspectRatio(contentMode: .fit)
          .foregroundColor(.white)
          .frame(width: 192, height: 192)
        Spacer()
      }
      .navigationTitle("\(item.title)")
      .frame(maxWidth: .infinity, alignment: .center)
      .background(item.color)
    }
  }
}
```

The side menu style can be easily switched by simply changing the __configuration__ value from __.slide__ to __.sidebar__.


```swift
  private let configuration: SideMenuConfiguration = .slide
```

```swift
  private let configuration: SideMenuConfiguration = .sidebar
```

## License

This package is licensed under [BSD License](LICENSE)
