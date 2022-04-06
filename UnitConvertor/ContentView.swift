//
//  ContentView.swift
//  UnitConvertor
//
//  Created by KK NGAI on 5/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 36.5
    @State private var inputUnitSelected = "Celsius"
    @State private var outputUnitSelected = "Fahrenheit"
    @FocusState private var inputIsFocus: Bool
    
    let unitStringList = ["Celsius", "Fahrenheit", "Kelivn"]
    
    var tempertureFormatter: MeasurementFormatter {
        let tempertureFormatter = MeasurementFormatter()
        tempertureFormatter.unitOptions = .providedUnit
        tempertureFormatter.numberFormatter.maximumFractionDigits = 2
        
        return tempertureFormatter
    }
    
    var convertedUnitValue: String {
        let inputSelectedUnit = getUnit(from: inputUnitSelected)
        let outputSelectedUnit = getUnit(from: outputUnitSelected)
        let convertedMeasurment = Measurement.init(value: input, unit: inputSelectedUnit)
            .converted(to: outputSelectedUnit)
        
        return tempertureFormatter.string(from: convertedMeasurment)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocus)
                        .foregroundColor(inputIsFocus ? .blue : .black)
                    
                    Picker("Input", selection: $inputUnitSelected) {
                        ForEach(unitStringList, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
            
                Section {
                    Text(convertedUnitValue)
                    
                    Picker("Convert to unit", selection: $outputUnitSelected) {
                        ForEach(unitStringList, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
            }
            .navigationTitle("Unit conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocus = false
                    }
                }
            }
        }
    }
    
    func getUnit(from unitString: String) -> UnitTemperature {
        switch unitString {
        case "Celsius":
            return UnitTemperature.celsius
        case "Fahrenheit":
            return UnitTemperature.fahrenheit
        case "Kelivn":
            return UnitTemperature.kelvin
        default:
            return UnitTemperature.celsius
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
