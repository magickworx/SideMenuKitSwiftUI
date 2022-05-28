/*
 * FILE:	SidebarMenuView.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Manage the Menus on Sidebar
 * DATE:	Tue, May 24 2022
 * UPDATED:	Fri, May 27 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

struct SidebarMenuView<Menu>: View where Menu: Hashable
{
  private let items: [SideMenuItem<Menu>]

  @Binding private var selected: Menu
  @Binding private var showsSidebar: Bool

  init(items: [SideMenuItem<Menu>], selected: Binding<Menu>, showsSidebar: Binding<Bool>) {
    self.items = items
    self._selected = selected
    self._showsSidebar = showsSidebar
  }

  @ViewBuilder
  var body: some View {
    ScrollView(showsIndicators: false) {
      ForEach(items) { item in
        SidebarMenuItem(item, selected: $selected, showsSidebar: $showsSidebar)
      }
    }
    .padding(.top, 70.0)
    .edgesIgnoringSafeArea(.all)
  }
}
