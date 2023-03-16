//
//  OnboardingView+Helper.swift
//  LittleLemon
//
//  Created by Jo Michael on 3/16/23.
//

import Foundation
import SwiftUI
import UIKit

struct OnboardingView: View {
    @Binding var shouldShowOnBoarding: Bool
    
    var body: some View {
        ZStack {
            background
            TabView {
                PageView(image: "lagom-waitress-brings-coffee-to-a-customer", messageDescription: "We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.", showDismissButton: false, shouldShowOnBoarding: $shouldShowOnBoarding)
                
                PageView(image: "lagoom-man-and-woman-on-romantic-date-at-a-table-in-cafe", messageDescription: "from romatic night date to casual family reservation, Little lemon is here to forfill it", showDismissButton: false, shouldShowOnBoarding: $shouldShowOnBoarding)
                
                PageView(image: "vivid-young-couple-standing-behind-the-bar-at-a-restaurant-overlooking-the-city", messageDescription: "Booking your reservation in on click", showDismissButton: true, shouldShowOnBoarding: $shouldShowOnBoarding)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear() {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            }
            .onDisappear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .none
                UIPageControl.appearance().pageIndicatorTintColor = nil
            }
        }
    }
    
    var background: some View {
        LinearGradient(
            gradient: Gradient (stops: [
            .init (color: Color("Secondary-white"), location: 0),
                .init (color: Color("Secondary-white"), location: 1)]),
                       startPoint: UnitPoint(x: 0.5000000291053439, y: 1.0838161507153998-8),
                       endPoint: UnitPoint(x: -0.002089660354856915, y: 0.976613295904758))
        .ignoresSafeArea()
    }
}

struct PageView: View {
    var image: String
    var messageDescription: String?
    var showDismissButton: Bool
    @Binding var shouldShowOnBoarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .interpolation(.none)
                .aspectRatio(contentMode: .fit)
            
            Text(messageDescription ?? "")
                .foregroundColor(Color("Green"))
                .font(Font.custom("Karla", size: 24, relativeTo: .subheadline))
            
            Spacer()
            
            if showDismissButton {
                Button {
                    shouldShowOnBoarding.toggle()
                } label: {
                    Text("Get Start")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color("Green"))
                        .cornerRadius(6)
                        
                }
                .padding(.bottom)

            }
        }
        .padding([.leading, .trailing, .bottom], 20)
    }
}
