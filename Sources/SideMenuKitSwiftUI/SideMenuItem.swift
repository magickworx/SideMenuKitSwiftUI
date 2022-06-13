/*
 * FILE:	SideMenuItem.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Menu Item for Sidebar
 * DATE:	Wed, Apr 27 2022
 * UPDATED:	Mon, Jun 13 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

public protocol SMKMenuItem: Hashable, Identifiable
{
  associatedtype Tag: Hashable

  var id: String { get }

  var title: String { get }
  var icon: Image { get }
  var tag: Tag { get }
  var color: Color { get }
}

public struct SMKSideMenuItem<Menu>: SMKMenuItem where Menu: Hashable
{
  public typealias Tag = Menu

  public let id: String = UUID().uuidString // to use "ForEach"

  public let title: String
  public let icon: Image
  public let tag: Tag
  public let color: Color

  public init(title: String, icon: Image, tag: Tag, color: Color = .gray) {
    self.title = title
    self.icon = icon
    self.tag = tag
    self.color = color
  }

  public init(title: String, icon systemName: String, tag: Tag, color: Color = .gray) {
    self.title = title
    self.icon = Image(systemName: systemName)
    self.tag = tag
    self.color = color
  }
}

// MARK: - Defaults
extension SMKMenuItem
{
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(title)
    hasher.combine(tag)
  }
}
