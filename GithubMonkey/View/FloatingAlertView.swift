//
//  FloatingNoticeView.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 11/5/23.
//

import SwiftUI

struct FloatingAlertView: View {
    @Binding var showingNotice: Bool
    let image:Image?
    let message:String
    let activeTime:Double
    let opacityValue:Double
    let cornerRadiousVlaue:Double
    let imageSize:Double
    
    public init(showingNotice: Binding<Bool>, image: Image?, activeTime:Double=1, message: String, opacity: Double = 0.90, cornerRadious:Double = 35, imageSize:Double=48) {
        self._showingNotice = showingNotice
        self.image = image
        self.message = message
        self.opacityValue = opacity
        self.cornerRadiousVlaue = cornerRadious
        self.imageSize = imageSize
        self.activeTime = activeTime
    }
    
    public var body: some View {
        VStack (alignment: .center, spacing: 8) {
            image
                .foregroundColor(.white)
                .font(.system(size: imageSize, weight: .regular))
            if message != ""{
                Text(message)
                    .foregroundColor(.white)
                    .font(.callout)
            }
        }
        .padding(20)
        .background(Color.gray.opacity(opacityValue))
        .cornerRadius(cornerRadiousVlaue)
        .transition(.scale)
        .onAppear{
            withAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + activeTime){
                    self.showingNotice = false
                }
            }
        }
    }
}
