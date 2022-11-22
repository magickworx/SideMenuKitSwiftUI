/*
 * FILE:	SlideMenuStack.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Slide Menu Stack Container
 * DATE:	Tue, Apr 26 2022
 * UPDATED:	Mon, Nov 21 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 * REFERENCES:	https://betterprogramming.pub/create-a-sidebar-menu-180ca218eaf2
 */

import SwiftUI

public struct SMKSlideMenuStack<SidebarContent,Content>: View where SidebarContent: View, Content: View
{
  private let sidebarContent: SidebarContent
  private let mainContent: Content
  private let sidebarWidth: CGFloat
  @Binding private var showsSidebar: Bool

  public init(sidebarWidth: CGFloat, showsSidebar: Binding<Bool>, @ViewBuilder sidebar: () -> SidebarContent, @ViewBuilder content: () -> Content) {
    self.sidebarWidth = sidebarWidth
    self._showsSidebar = showsSidebar
    sidebarContent = sidebar()
    mainContent = content()
  }

  private var _navigationPath: Any?
  @available(iOS 16.0, *)
  private var navigationPath: Binding<NavigationPath> {
    get {
      return _navigationPath as! Binding<NavigationPath>
    }
    set {
      _navigationPath = newValue
    }
  }

  @available(iOS 16.0, *)
  public init(navigationPath: Binding<NavigationPath>, sidebarWidth: CGFloat, showsSidebar: Binding<Bool>, @ViewBuilder sidebar: () -> SidebarContent, @ViewBuilder content: () -> Content) {
    self.sidebarWidth = sidebarWidth
    self._showsSidebar = showsSidebar
    sidebarContent = sidebar()
    mainContent = content()
    self.navigationPath = navigationPath
  }

  public var body: some View {
    ZStack(alignment: .leading) {
      makeContentOfMenu()
      makeContentOfNavigation()
      .overlay(
        Group {
          if showsSidebar {
            Color.white
              .opacity(showsSidebar ? 0.01 : 0.0)
              .onTapGesture {
                self.showsSidebar = false
              }
          }
          else {
            Color.clear
              .opacity(showsSidebar ? 0.0 : 0.0)
              .onTapGesture {
                self.showsSidebar = false
              }
          }
        }
      )
      .offset(x: showsSidebar ? sidebarWidth : 0.0, y: 0.0)
      .animation(Animation.easeInOut.speed(2.0), value: showsSidebar)
    }
  }
}

extension SMKSlideMenuStack
{
  private func makeContentOfMenu() -> some View {
    sidebarContent
      .frame(width: sidebarWidth, alignment: .center)
      .offset(x: showsSidebar ? 0.0 : -1.0 * sidebarWidth, y: 0.0)
      .animation(Animation.easeInOut.speed(2.0), value: showsSidebar)
  }

  private func makeContentOfMain() -> some View {
    mainContent
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            withAnimation {
              self.showsSidebar.toggle()
            }
          }) {
            Image(systemName: "line.3.horizontal")
              .imageScale(.large)
              .foregroundColor(.primary)
          }
        }
      }
  }

  private func makeContentOfNavigation() -> some View {
    Group {
      if #available(iOS 16.0, *) {
        NavigationStack(path: self.navigationPath) {
          makeContentOfMain()
        }
      }
      else {
        NavigationView {
          makeContentOfMain()
        }
      }
    }
  }
}
