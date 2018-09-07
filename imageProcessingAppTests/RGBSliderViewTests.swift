//
//  RGBSliderViewTests.swift
//  imageProcessingAppTests
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import XCTest
@testable import imageProcessingApp

class RGBSliderViewTests: XCTestCase {
    
    var rgbSliderView:RGBSliderView!
    
    override func setUp() {
        super.setUp()
        rgbSliderView = RGBSliderView(frame: CGRect(x: 0, y: 0, width: 100, height: 200) )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        rgbSliderView = nil
    }
    
    //test validate change in rgb inputs
    func testValidateRGBInputs(){
        
        let (minValueBrightness, maxValueBrightness) = ChannelProperty.Brightness.getMinMaxValues()
        let (minValueContrast, maxValuesContrast) = ChannelProperty.Contrast.getMinMaxValues()
        
        let redChannelData = ChannelColorFilterData(channelName: .Red)
        let greenChannelData = ChannelColorFilterData(channelName: .Green)
        let blueChannelData = ChannelColorFilterData(channelName: .Blue)
     
        let randomGreenChannelContrast = Float.random(lower: Float(minValueContrast), Float(maxValuesContrast))
        let randomBlueChannelContrast = Float.random(lower: Float(minValueContrast), Float(maxValuesContrast))
        let randomRedChannelContrast = Float.random(lower: Float(minValueContrast), Float(maxValuesContrast))
        
        
        let randomRedChannelBrightness = Float.random(lower: Float(minValueBrightness), Float(maxValueBrightness))
        let randomGreenChannelBrightness = Float.random(lower: Float(minValueBrightness), Float(maxValueBrightness))
        let randomBlueChannelBrightness = Float.random(lower: Float(minValueBrightness), Float(maxValueBrightness))
        
        
        redChannelData.properties[.Brightness] = CGFloat(randomRedChannelBrightness)
        redChannelData.properties[.Contrast] = CGFloat(randomRedChannelContrast)
        
        greenChannelData.properties[.Brightness] = CGFloat(randomGreenChannelBrightness)
        greenChannelData.properties[.Contrast] = CGFloat(randomGreenChannelContrast)
        
        blueChannelData.properties[.Brightness] = CGFloat(randomBlueChannelBrightness)
        blueChannelData.properties[.Contrast] = CGFloat(randomBlueChannelContrast)
        
        
        rgbSliderView.setData(redChannelData, for: .Red)
        rgbSliderView.setData(greenChannelData, for: .Green)
        rgbSliderView.setData(blueChannelData, for: .Blue)
        
        rgbSliderView.updateSelectedChannel(.Red)
        XCTAssertTrue(rgbSliderView.slider1.value == Float(randomRedChannelContrast))
        XCTAssertTrue(rgbSliderView.slider2.value == Float(randomRedChannelBrightness))
        
        rgbSliderView.updateSelectedChannel(.Green)
        XCTAssertTrue(rgbSliderView.slider1.value == Float(randomGreenChannelContrast))
        XCTAssertTrue(rgbSliderView.slider2.value == Float(randomGreenChannelBrightness))
        
        rgbSliderView.updateSelectedChannel(.Blue)
        XCTAssertTrue(rgbSliderView.slider1.value == Float(randomBlueChannelContrast))
        XCTAssertTrue(rgbSliderView.slider2.value == Float(randomBlueChannelBrightness))
    }
    
    //test to confirm default values where set for r g b sliders
    func testValidateRGBDefaults(){
        XCTAssert(rgbSliderView.data.count == 3)
        
        let redChannelData = rgbSliderView.data[ChannelName.Red.rawValue]
        let greenChannelData = rgbSliderView.data[ChannelName.Green.rawValue]
        let blueChannelData = rgbSliderView.data[ChannelName.Blue.rawValue]
        
        //check that channel data was changed successfully
        XCTAssert(redChannelData != nil)
        XCTAssert(greenChannelData != nil)
        XCTAssert(blueChannelData != nil)
        
        //check that two properties where properly initialized
        XCTAssert(redChannelData!.properties.count == 2)
        XCTAssert(greenChannelData!.properties.count == 2)
        XCTAssert(blueChannelData!.properties.count == 2)
        
        
        XCTAssert(redChannelData!.channelName == .Red)
        XCTAssert(greenChannelData!.channelName == .Green)
        XCTAssert(blueChannelData!.channelName == .Blue)
        
        
        XCTAssert(redChannelData!.properties[ChannelProperty.Brightness] != nil)
        XCTAssert(redChannelData!.properties[ChannelProperty.Contrast] != nil)
        
        XCTAssert(greenChannelData!.properties[ChannelProperty.Brightness] != nil)
        XCTAssert(greenChannelData!.properties[ChannelProperty.Contrast] != nil)
        
        XCTAssert(blueChannelData!.properties[ChannelProperty.Brightness] != nil)
        XCTAssert(blueChannelData!.properties[ChannelProperty.Contrast] != nil)
        
        
        
        XCTAssert(redChannelData!.properties[ChannelProperty.Brightness]! == ChannelProperty.Brightness.defaultValue)
        XCTAssert(redChannelData!.properties[ChannelProperty.Contrast]! ==
            ChannelProperty.Contrast.defaultValue)
        
        XCTAssert(greenChannelData!.properties[ChannelProperty.Brightness]! == ChannelProperty.Brightness.defaultValue)
        XCTAssert(greenChannelData!.properties[ChannelProperty.Contrast]! == ChannelProperty.Contrast.defaultValue)
        
        XCTAssert(blueChannelData!.properties[ChannelProperty.Brightness]! == ChannelProperty.Brightness.defaultValue)
        XCTAssert(blueChannelData!.properties[ChannelProperty.Contrast]! == ChannelProperty.Contrast.defaultValue)
   
    }
    

  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
