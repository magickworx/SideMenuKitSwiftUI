/*
 * FILE:	SlideMenuView.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Manages the Slide Menus on Sidebar
 * DATE:	Mon, May 23 2022
 * UPDATED:	Fri, May 27 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

struct SlideMenuView<Menu>: View where Menu: Hashable
{
  private let items: [SideMenuItem<Menu>]

  @Binding private var selected: Menu
  @Binding private var showsSidebar: Bool

  private let configuration: SideMenuConfiguration

  init(items: [SideMenuItem<Menu>], selected: Binding<Menu>, showsSidebar: Binding<Bool>, configuration: SideMenuConfiguration) {
    self.items = items
    self._selected = selected
    self._showsSidebar = showsSidebar
    self.configuration = configuration
  }

  @ViewBuilder
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(items) { item in
        SlideMenuItem(item, configuration: configuration, selected: $selected, showsSidebar: $showsSidebar)
      }
      .padding(.top, 30.0)
      Spacer()
    }
    .padding()
    .padding(.top, 70.0)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(configuration.backgroundColor)
    .edgesIgnoringSafeArea(.all)
  }
}
