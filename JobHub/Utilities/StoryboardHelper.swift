//
//  File.swift
//  Sloggers
//
//  Created by Ankit Angra on 05/02/17.
//  Copyright © 2017 NewMediaTechies. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum StoryboardIdentifiers : String {
        case JobTitleController = "jobTitleVC"
        case JobIndustryController = "jobIndustryVC"
        case JobLocationController = "jobLocationVC"
        case JobSearchController = "jobSearchVC"
    }
    // LoginStoryboard
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func homeStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "HomeStoryboard", bundle: Bundle.main)
    }

}
