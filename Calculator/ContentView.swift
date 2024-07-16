//
//  ContentView.swift
//  Calculator
//
//  Created by 박예린 on 7/13/24.
//

import SwiftUI

enum ButtonType: String {
    case first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, zero
    case dot, equal, plus, minus, multiply, divide
    case percent, opposite, clear
    
    var buttonDisplayName: String {
        switch self {
        case .first:
            return "1"
        case .second:
            return "2"
        case .third:
            return "3"
        case .fourth:
            return "4"
        case .fifth:
            return "5"
        case .sixth:
            return "6"
        case .seventh:
            return "7"
        case .eighth:
            return "8"
        case .ninth:
            return "9"
        case .zero:
            return "0"
        case .dot:
            return "."
        case .equal:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        case .percent:
            return "%"
        case .opposite:
            return "+/-"
        case .clear:
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth, .ninth, .zero, .dot:
            return Color("NumberButton")
        case .equal, .plus, .minus, .multiply, .divide:
            return Color.orange
        case .percent, .opposite, .clear:
            return Color.gray
        }
    }
    
    var fontColor: Color {
        switch self {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth, .ninth, .zero, .dot, .equal, .plus, .minus, .multiply, .divide:
            return Color.white
        case .percent, .opposite, .clear:
            return Color.black
        }
    }
}

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .divide],
        [.seventh, .eighth, .ninth, .multiply],
        [.fourth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button {
                                handleButtonPress(item)
                            } label: {
                                Text(item.buttonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(button: item),
                                           height: calculateButtonHeight(button: item))
                                    .background(item.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.fontColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func handleButtonPress(_ item: ButtonType) {
        if totalNumber == "0" {
            if item == .clear {
                totalNumber = "0"
            } else if item == .plus || item == .minus || item == .multiply || item == .divide {
                totalNumber = "Error"
            } else {
                totalNumber = item.buttonDisplayName
            }
        } else {
            if item == .clear {
                totalNumber = "0"
            } else if item == .plus {
                tempNumber = Int(totalNumber) ?? 0
                operatorType = .plus
                totalNumber = "0"
            } else if item == .multiply {
                tempNumber = Int(totalNumber) ?? 0
                operatorType = .multiply
                totalNumber = "0"
            } else if item == .minus {
                tempNumber = Int(totalNumber) ?? 0
                operatorType = .minus
                totalNumber = "0"
            } else if item == .equal {
                if operatorType == .plus {
                    totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                } else if operatorType == .multiply {
                    totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                } else if operatorType == .minus {
                    totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                }
            } else {
                totalNumber += item.buttonDisplayName
            }
        }
    }
    
    private func calculateButtonWidth(button buttonType: ButtonType) -> CGFloat {
        if buttonType == .zero {
            return (UIScreen.main.bounds.width - 5 * 10)
        } else {
            return (UIScreen.main.bounds.width - 5 * 10) / 2
        }
    }
    
    private func calculateButtonHeight(button: ButtonType) -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
}

#Preview {
    ContentView()
}
