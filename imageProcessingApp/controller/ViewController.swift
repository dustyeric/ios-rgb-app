//
//  ViewController.swift
//  imageProcessingApp
//
//  Created by Dusty on 9/6/18.
//  Copyright © 2018 CWG-PLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewContainer: UIView!
    var openGlImageView:OpenGLImageView!
    
    @IBOutlet weak var rgbSliderView: RGBSliderView!
    var originalImageView = #imageLiteral(resourceName: "sampleImage")
    
    @IBOutlet weak var sliderContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func registerCustomFilters(){
        //registering a custom filter
        CIFilter.registerName("RGBChannelBrightnessAndContrast",
                              constructor: CustomFiltersVendor(),
                              classAttributes: [kCIAttributeFilterCategories :[kCICategoryStillImage]])
    }
    
    
    @IBAction func getNewImage(_ sender: Any) {
        
       
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            
            self.originalImageView = image
            self.openGlImageView.image = CIImage(image: image)
            
            //TODO: reset the image slider view values
            NSLog("reseting slider data")
            self.rgbSliderView.resetData()
            
        }
        
    }
    
    
    func setupView(){
       
        //init the custom gl view
        initGlImageView()
        
        registerCustomFilters()
        
        setupRGBSliderView()
    }
    
    
    private func setupRGBSliderView(){
        rgbSliderView.delegate = self
    }
 
    
    private func initGlImageView(){
        //set the image view to the container
        openGlImageView = OpenGLImageView(frame: imageViewContainer.frame)
        //init the image
        openGlImageView.image = CIImage(image: originalImageView)
        
        imageViewContainer.addSubview(openGlImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: RGBSliderViewDelegate{
    
    func applyfiltersAndUpdateImage(rgbColorFilterData : [String : ChannelColorFilterData]){
        
        var parameters : [String : CGFloat] = [:]
        // compose the filter parameter list using the input+channelname+propery i.e inputRedContrast will be the input for contrast property
        for (channelName, channelColorFilterData) in rgbColorFilterData{
            for (channelProperty, value) in channelColorFilterData.properties{
                let key = "input\(channelName)\(channelProperty.rawValue)"
                parameters[key] = value
            }
        }
        
         let image = CIImage(image: originalImageView)
        //apply brightness contrast filter
         if let image = image{
             let result = image.applyingFilter("RGBChannelBrightnessAndContrast",
             parameters: parameters)
            
            //update the image
            self.openGlImageView.image = result
         }else{
            
            NSLog("Error: unable to convert image to CI image")
        }
    }
    
    func onRGBColorDataUpdated(rgbColorFilterData: [String : ChannelColorFilterData]) {
        applyfiltersAndUpdateImage(rgbColorFilterData: rgbColorFilterData)
    }
}



