/*
 * FILE:	SidebarMenuItem.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: View to Display Menu Icon on Sidebar
 * DATE:	Tue, May 24 2022
 * UPDATED:	Tue, May 24 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

struct SidebarMenuItem<Item>: View where Item: SideMenuKitMenuItem
{
  private let item: Item

  @Binding private var selected: Item.Tag
  @Binding private var showsSidebar: Bool

  init(_ item: Item, selected: Binding<Item.Tag>, showsSidebar: Binding<Bool>) {
    self.item = item
    self._selected = selected
    self._showsSidebar = showsSidebar
  }

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(item.color)
      item.icon
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 64, height: 64)
        .foregroundColor(.white)
        .padding()
    }
    .frame(width: 80, height: 80)
    .gesture(tap)
  }
}

// MARK: - Tap Gesture
extension SidebarMenuItem
{
  private var tap: some Gesture {
    TapGesture(count: 1)
      .onEnded { _ in
        self.handleTapGesture()
      }
  }

  private func handleTapGesture() {
    if selected != item.tag {
      self.selected = item.tag
    }
    self.showsSidebar = false
  }
}
