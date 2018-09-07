//
//  RGBSliderView.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit

@objc protocol RGBSliderViewDelegate {
    @objc optional func onRGBColorDataUpdated(rgbColorFilterData:[String:ChannelColorFilterData])
}

class RGBSliderView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var channelTextLabel: UITextField!
    var channelPicker:UIPickerView!
    let channels = [ChannelName.Red, ChannelName.Green, ChannelName.Blue]
    var selectedChannel:ChannelName!
    var delegate:RGBSliderViewDelegate?
    var data:[String:ChannelColorFilterData] = [:]
    
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider1Label: UILabel!
    @IBOutlet weak var slider2Label: UILabel!
    var property1:ChannelProperty = .Contrast
    var property2:ChannelProperty = .Brightness
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setSliderProperties(property1:ChannelProperty, property2:ChannelProperty){
        self.property1 = property1
        self.property2 = property2
        //call slider set up to refresh sliders
        setupSliders()
        initData()
    }
   
    private func commonInit(){
    Bundle.main.loadNibNamed("RGBSliderView",
                                 owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //set up the channel picker
        setupChannelPicker()
        //set up sliders
        setupSliders()
        
        //init data
        initData()
    }
    
    //resets all channel slider data to the property default values
    func resetData(){
        //reset the data
        initData()
        updateSelectedChannel(selectedChannel)
    }
    
    func setData(_ channelColorFilterData:ChannelColorFilterData, for channel:ChannelName){
        self.data[channel.rawValue] = channelColorFilterData
        updateSelectedChannel(channel)
    }
    
    private func setupSliders(){
        
        //TODO: expand this to be dynamic
        slider1Label.text = property1.rawValue
        slider2Label.text = property2.rawValue
        
        
        //set up the minium and maximum values of properties
        //contrastSlider
        let (slider1Min, slider1Max) = property1.getMinMaxValues()
        slider1.minimumValue = Float(slider1Min)
        slider1.maximumValue = Float(slider1Max)
        
        let (slider2Min, slider2Max) = property2.getMinMaxValues()
        slider2.minimumValue = Float(slider2Min)
        slider2.maximumValue = Float(slider2Max)
        
    
        //init the recorded values to the defaults
        slider1.value = Float(property1.defaultValue)
        slider2.value = Float(property2.defaultValue)
        
        slider1.addTarget(self, action: #selector(onSliderValueChanged), for: .valueChanged)
        slider2.addTarget(self, action: #selector(onSliderValueChanged), for: .valueChanged)
    
    }
    
    @objc func onSliderValueChanged(_ slider:UISlider){
        if slider == slider1{
            data[selectedChannel.rawValue]?.properties[property1] = CGFloat(slider.value)
        }else{
            data[selectedChannel.rawValue]?.properties[property2] = CGFloat(slider.value)
        }
        //propergate back change real time to parent view
        delegate?.onRGBColorDataUpdated?(rgbColorFilterData: data)
       
    }
    
    private func initData(){
        for channel in channels{
            data[channel.rawValue] = ChannelColorFilterData(channelName: channel)
            
            data[channel.rawValue]?.properties[property1] = CGFloat(property1.defaultValue)
            data[channel.rawValue]?.properties[property2] = CGFloat(property2.defaultValue)
        }
    }
    
 
    
    //sets up the channel picker
    private func setupChannelPicker(){
        channelPicker = UIPickerView()
        channelPicker.delegate = self
        channelPicker.dataSource = self
        
        
        channelTextLabel.inputView = channelPicker
        channelTextLabel.delegate = self
        
        //init selected channel to red
        updateSelectedChannel(.Red)
    }
    
    //loads the slider values for a channel to the ui
    private func loadSliderValues(for channel:ChannelName){
        if let properties = data[channel.rawValue]?.properties{
            if let property = properties[property1]{
                slider1.value = Float(property)
            }
            
            if let property = properties[property2]{
                slider2.value = Float(property)
            }
        }
    }
    
    
    public func updateSelectedChannel(_ channel:ChannelName){
        selectedChannel = channel
        channelTextLabel.text = channel.rawValue
        loadSliderValues(for: channel)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateSelectedChannel(channels[row])
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  channels[row].rawValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return channels.count
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            contentView.superview?.superview?.animateViewMoving(up: false, moveValue: 200)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            contentView.superview?.superview?.animateViewMoving(up: true, moveValue: 200)
    }

}
