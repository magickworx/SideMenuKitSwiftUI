/*
 * FILE:	SlideMenuItem.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Slide Menu Item on Sidebar
 * DATE:	Wed, Apr 27 2022
 * UPDATED:	Fri, Jun 17 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

struct SlideMenuItem<Item>: View where Item: SMKMenuItem
{
  private let item: Item
  private let configuration: SMKSideMenuConfiguration
  private let selectedColor: Color

  @Binding private var selected: Item.Tag
  @Binding private var showsSidebar: Bool

  init(_ item: Item, configuration: SMKSideMenuConfiguration, selected: Binding<Item.Tag>, showsSidebar: Binding<Bool>) {
    self.item = item
    self.configuration = configuration
    self.selectedColor = configuration.selectedColor
    self._selected = selected
    self._showsSidebar = showsSidebar
  }

  var body: some View {
    Group {
      switch configuration.selectedStyle {
        case .pinpoint:
          menuBody().foregroundColor(item.color)
            .background(alignment: .trailing) {
              Circle()
                .foregroundColor((item.tag == selected) ? self.selectedColor : .clear)
                .frame(width: 8, height: 8)
            }
        case .highlight:
          menuBody()
            .foregroundColor((item.tag == selected) ? self.selectedColor : item.color)
        case .underline:
          menuBody().foregroundColor(item.color)
            .background(alignment: .bottom) {
              Group {
                if item.tag == selected {
                  Rectangle().foregroundColor(self.selectedColor)
                }
                else {
                  Color.clear
                }
              }
              .frame(height: 2)
            }
        default:
          menuBody().foregroundColor(item.color)
      }
    }
    .frame(height: 20)
  }

  private func menuBody() -> some View {
    HStack {
      item.icon
        .resizable()
        .aspectRatio(contentMode: .fit)
      Text(item.title).font(.headline)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .contentShape(Rectangle()) // XXX: 空白領域をタップ可能にする仕掛け
    .gesture(tap)
  }
}

// MARK: - Tap Gesture
extension SlideMenuItem
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
