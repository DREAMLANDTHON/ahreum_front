//
//  View.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

extension View {
    func paddingHorizontal() -> some View {
        self
            .padding(.horizontal, 18)
    }
    var dividerThick1: some View {
        return Rectangle()
            .foregroundColor(Color(hex: "D6D6D6"))
            .frame(height: 0.5)
    }
    func ImageView(url: URL) -> some View {
        AsyncImage(url: url) { image in
                image.resizable()
                .scaledToFill()
            } placeholder: {
                Image("loadingBack").resizable()
                    .scaledToFill()
                    .overlay {
                        ProgressView()
                    }
            }
    }
    func ballTicket(number: Int, color: Color, isNumber: Bool, size: CGFloat = 26 ) -> some View {
        Circle()
            .buttonmedium17()
            .foregroundColor(color)
            .frame(width: size, height: size)
            .overlay {
                if isNumber {
                    Text("\(number)")
                        .foregroundColor(.white)
                }
            }
    }
    func alignment(_ position: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Font
    func bodymedium12() -> some View {
        self
            .font(.custom("Pretendard-Medium", size: 12))
    }
    func titleBold17() -> some View {
        self
            .font(.custom("Pretendard-Bold", size: 17))
    }
    func titleBold20() -> some View {
        self
            .font(.custom("Pretendard-Bold", size: 20))
    }
    func buttonBold12() -> some View {
        self
            .font(.custom("Pretendard-Bold", size: 12))
    }
    func buttonBold14() -> some View {
        self
            .font(.custom("Pretendard-Bold", size: 14))
    }
    func buttonmedium17() -> some View {
        self
            .font(.custom("Pretendard-Medium", size: 17))
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    /// 네비게이션 바 지우기
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }
}

class Utils {
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}


