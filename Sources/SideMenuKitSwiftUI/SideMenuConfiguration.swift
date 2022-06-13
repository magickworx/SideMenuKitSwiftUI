/*
 * FILE:	SideMenuConfiguration.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Customizes Style of Sidebar
 * DATE:	Tue, May 24 2022
 * UPDATED:	Mon, Jun 13 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

public struct SMKSideMenuConfiguration
{
  public enum MenuStyle
  {
    case slide
    case sidebar
  }
  public var menuStyle: MenuStyle

  public var sidebarWidth: CGFloat

  public enum SelectedStyle
  {
    case none
    case pinpoint
    case highlight
    case underline
  }
  public var selectedStyle: SelectedStyle
  public var selectedColor: Color

  public var backgroundColor: Color
}

extension SMKSideMenuConfiguration
{
  public static var `default`: SMKSideMenuConfiguration {
    SMKSideMenuConfiguration(
      menuStyle: .slide,
      sidebarWidth: 240,
      selectedStyle: .highlight,
      selectedColor: .pink,
      backgroundColor: .init(red: 32/255, green: 32/255, blue: 32/255)
    )
  }

  public static var slide: SMKSideMenuConfiguration {
    SMKSideMenuConfiguration(
      menuStyle: .slide,
      sidebarWidth: 160,
      selectedStyle: .pinpoint,
      selectedColor: .pink,
      backgroundColor: .init(red: 32/255, green: 32/255, blue: 32/255)
    )
  }

  public static var sidebar: SMKSideMenuConfiguration {
    SMKSideMenuConfiguration(
      menuStyle: .sidebar,
      sidebarWidth: 80,
      selectedStyle: .none,
      selectedColor: .pink,
      backgroundColor: .init(red: 32/255, green: 32/255, blue: 32/255)
    )
  }
}
