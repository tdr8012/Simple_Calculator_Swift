//
//  KeyView.swift
//  Calculator App (0725)
//
//  Created by english on 2024-09-26.
//

import SwiftUI

struct KeyView: View {
    
    @State var value = "0"
    @State var runningNumber: Double = 0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    let buttons: [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]
    var body: some View {
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(changeColor ? Color.num :Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ? 1.5 : 1)
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeInOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        self.changeColor.toggle()
                    }).overlay(
                        Text(self.value)
                            .font(.system(size: 100))
                            .foregroundStyle(.black)
                    )
            }
            .padding()
            
            ForEach(buttons, id: \.self){
                row in
                HStack(spacing: 10){
                    ForEach(row, id: \.self){
                        element in
                        Button(action: {
                         self.didTap(button: element)
                        }, label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .frame(width: getWidth(element: element), height: getHeight(element: element))
                                .foregroundStyle(.black)
                                .background(element.buttonColor)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .shadow(color: .purple.opacity(0.5), radius: 30)
                        })
                    }
                    
                    
                }
            }
            
            
        }
    }
    
    //get the width of the button
    func getWidth(element: Keys) -> CGFloat{
        if element == .zero{
            return(UIScreen.main.bounds.width - (5*10)) / 2
        }
        return(UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    //get the height of the button
    func getHeight(element: Keys) -> CGFloat{
        return(UIScreen.main.bounds.width - (5*10)) / 5
    }
    func didTap(button: Keys){
        switch button{
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                    
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide:
                    if currentValue == 0 {
                        self.value = ("Error")
                        break;
                    }
                    else{
                        self.value = "\(runningValue / currentValue)"
                    }
                case .none: break
                }
            }
            if button != .equal {
                self.value = ("0")
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            if button == .decimal{
                
                //if self.value.contains("."){
                //    self.value = self.value.replacingOccurrences(of: ".", with: "")
                //} doesnt sound logical so i removed it
                //else{
                  //  self.value = ("\(self.value).")
                if !self.value.contains("."){
                    self.value = ("\(self.value).")
                    
                }
                
            }
            else if button == .negative{
                let currentNumber = Double(self.value) ?? 0
                self.value = ("\(currentNumber * -1)")
            
            }
            else{
                let currentValue = Double(self.value) ?? 0
                self.value = ("\(currentValue / 100)")
            }
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
}

#Preview {
    KeyView()
}
