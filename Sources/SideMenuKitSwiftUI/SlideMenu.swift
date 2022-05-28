/*
 * FILE:	SlideMenu.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Side Menu View with Sliding Menu
 * DATE:	Mon, May 23 2022
 * UPDATED:	Fri, May 27 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

public struct SlideMenu<Menu,Content>: View where Menu: Hashable, Content: View
{
  @State private var showsSidebar: Bool = false
  @State private var selected: Menu

  private let configuration: SideMenuConfiguration
  private let menuItems: [SideMenuItem<Menu>]
  private let mainContent: (Menu) -> Content

  public init(configuration: SideMenuConfiguration = .default, menuItems: [SideMenuItem<Menu>], startItem: Menu, @ViewBuilder content: @escaping (Menu) -> Content) {
    self._selected = State(initialValue: startItem)
    self.configuration = configuration
    self.menuItems = menuItems
    self.mainContent = content
  }

  public init(sidebarWidth: CGFloat, menuItems: [SideMenuItem<Menu>], startItem: Menu, @ViewBuilder content: @escaping (Menu) -> Content) {
    var configuration: SideMenuConfiguration = .slide
    configuration.sidebarWidth = sidebarWidth
    self.init(configuration: configuration, menuItems: menuItems, startItem: startItem, content: content)
  }

  @ViewBuilder
  public var body: some View {
    SlideMenuStack(sidebarWidth: configuration.sidebarWidth, showsSidebar: $showsSidebar) {
      SlideMenuView<Menu>(items: menuItems, selected: $selected, showsSidebar: $showsSidebar, configuration: configuration)
        .frame(maxWidth: .infinity, alignment: .leading)
    } content: {
      mainContent(selected)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

// MARK: - Preview
struct SlideMenu_Previews: PreviewProvider
{
  enum Menu: Int, Hashable
  {
    case profile = 1
    case message
    case settings

    var title: String {
      switch self {
        case .profile:  return "Profile"
        case .message:  return "Message"
        case .settings: return "Settings"
      }
    }

    var backgroundColor: Color {
      switch self {
        case .profile:  return .purple
        case .message:  return .orange
        case .settings: return .pink
      }
    }
  }

  static private let items: [SideMenuItem<Menu>] = [
    (title: "Profile",  icon: "person",   tag: Menu.profile),
    (title: "Message",  icon: "envelope", tag: Menu.message),
    (title: "Settings", icon: "gear",     tag: Menu.settings)
  ].map({ SideMenuItem<Menu>(title: $0.title, icon: $0.icon, tag: $0.tag) })

  static var previews: some View {
    SlideMenu<Menu,ContentView>(menuItems: items, startItem: Menu.profile) {
      (menu) -> ContentView in
      ContentView(menu: menu)
    }
  }

  struct ContentView: View
  {
    let menu: Menu

    @ViewBuilder
    var body: some View {
      VStack {
        Spacer()
        Text("Hello \(menu.rawValue)").font(.title)
        Spacer()
      }
      .navigationTitle(menu.title)
      .frame(maxWidth: .infinity, alignment: .center)
      .background(menu.backgroundColor)
    }
  }
}
