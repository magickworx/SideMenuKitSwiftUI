/*
 * FILE:	SidebarMenuStack.swift
 * DESCRIPTION:	SideMenuKitSwiftUI: Sidebar Menu Stack Container
 * DATE:	Tue, May 24 2022
 * UPDATED:	Mon, Jun 13 2022
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		https://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2022 阿部康一／Kouichi ABE (WALL)
 * LICENSE:	The 2-Clause BSD License (See LICENSE.txt)
 */

import SwiftUI

public struct SMKSidebarMenuStack<MenuContent,Content>: View where MenuContent: View, Content: View
{
  private let menuContent: MenuContent
  private let mainContent: Content
  private let sidebarWidth: CGFloat
  @Binding private var showsSidebar: Bool

  private let menuOpenedAngle: CGFloat = 0
  private let menuClosedAngle: CGFloat = -90

  private let menuOpenedOffset: CGPoint = .zero
  private let menuClosedOffset: CGPoint

  public init(sidebarWidth: CGFloat, showsSidebar: Binding<Bool>, @ViewBuilder sidebar: () -> MenuContent, @ViewBuilder content: () -> Content) {
    self.sidebarWidth = sidebarWidth
    self._showsSidebar = showsSidebar
    menuContent = sidebar()
    mainContent = content()

    menuClosedOffset = CGPoint(x: sidebarWidth, y: 0)
  }

  @State private var contentOffset: CGPoint = .zero
  @State private var scrollDirection: ScrollDirection = .unknown
  @State private var scrollViewProxy: ScrollViewProxy?
  @State private var angle: CGFloat = 0

  private let menuID: Int = 1
  private let contentID: Int = 2

  public var body: some View {
    GeometryReader { geometry in
      let width: CGFloat = geometry.size.width
      let height: CGFloat = geometry.size.height
      BetterScrollView(axes: .horizontal, showsIndicators: false, contentOffset: $contentOffset, scrollDirection: $scrollDirection) { proxy in
        HStack(spacing: 0) {
          menuContent
            .frame(width: self.sidebarWidth)
            .id(menuID)
            .rotation3DEffect(.degrees(self.angle), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .trailing)
          NavigationView {
            mainContent
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  Button(action: {
                    self.toggleSidebar()
                  }, label: {
                    Image(systemName: "line.3.horizontal")
                      .imageScale(.large)
                      .foregroundColor(.primary)
                      .rotationEffect(.degrees(self.angle - 90))
                  })
                }
              }
              .overlay {
                self.touchableView()
              }
          }
          .frame(width: width, height: height)
          .id(contentID)
        }
        .onChange(of: contentOffset) { offset in
          self.angle = -((90.0 * offset.x) / self.sidebarWidth)
          switch self.angle {
            case   0: self.showsSidebar = true
            case -90: self.showsSidebar = false
            default: break
          }
        }
        .onChange(of: showsSidebar) { shows in
          self.openSidebar(shows)
        }
        .onAppear {
          self.scrollViewProxy = proxy
          self.toggleSidebar()
        }
      }
      .onScrollEnded {
        (offset, direction) in
        self.handleScrollEnd(offset: offset, direction: direction)
      }
    }
    .onAppear {
      UIScrollView.appearance().bounces = false
    }
    /*
    .overlay(alignment: .trailing) {
      Text(String(format: "angle: %.1f, offset: (%.1f, %.1f) [%@] ",angle,contentOffset.x,contentOffset.y, showsSidebar ? "open" : "close"))
    }
    */
  }
}

extension SMKSidebarMenuStack
{
  @ViewBuilder
  private func touchableView() -> some View {
    Group {
      if self.showsSidebar {
        Color.white
          .opacity(showsSidebar ? 0.01 : 0.0)
          .onTapGesture {
            self.showsSidebar = false
          }
      }
      else {
        Color.clear
          .onTapGesture {
            self.showsSidebar = false
          }
      }
    }
  }

  private func handleScrollEnd(offset: CGPoint, direction: ScrollDirection) {
    switch direction {
      case .right:
        if offset.x > menuOpenedOffset.x { self.openSidebar(true) }
      case .left:
        if offset.x < menuClosedOffset.x { self.openSidebar(false) }
      default:
        break
    }
  }

  private func openSidebar(_ shows: Bool) {
    if shows {
      if self.angle != menuOpenedAngle {
        self.angle = menuOpenedAngle
        self.openMenu()
      }
    }
    else {
      if self.angle != menuClosedAngle {
        self.angle = menuClosedAngle
        self.closeMenu()
      }
    }
  }

  private func toggleSidebar() {
    withAnimation {
      self.scrollViewProxy?.scrollTo(angle == menuOpenedAngle ? contentID : menuID, anchor: .leading)
    }
  }

  private func openMenu() {
    withAnimation {
      self.scrollViewProxy?.scrollTo(menuID, anchor: .leading)
    }
  }

  private func closeMenu() {
    withAnimation {
      self.scrollViewProxy?.scrollTo(contentID, anchor: .leading)
    }
  }
}
