//
//  ComplicationController.swift
//  wikiwiki WatchKit Extension
//
//  Created by Uygur Kıran on 9.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {

        handler(createTimelineEntry(forComplication: complication, date: Date()))
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    
    
    private func createTimelineEntry(forComplication complication: CLKComplication, date: Date) -> CLKComplicationTimelineEntry? {
        guard let template = createTemplate(forComplication: complication) else { return nil }
            
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    
    
    // MARK: - Placeholder Templates
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        
        handler(createTemplate(forComplication: complication))
    }
    
    
    
    //MARK: - Templates
    func createTemplate(forComplication complication: CLKComplication) -> CLKComplicationTemplate? {
        
        //corner
        let cornerTemplate = CLKComplicationTemplateGraphicCornerCircularImage()
        if let img = UIImage(named: "Graphic Circular") {
        cornerTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: img)
        }
      
        //graphicCircular
        let circularTemplate = CLKComplicationTemplateGraphicCircularImage()
        if let img2 = UIImage(named: "Graphic Circular") {
        circularTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: img2)
        }
        
        //circularSmall
        let circularSmall = CLKComplicationTemplateCircularSmallSimpleText()
        circularSmall.textProvider = CLKSimpleTextProvider(text: "W")
        
        
        switch complication.family {
        case .graphicCorner:
            if UIImage(named: "Graphic Circular") != nil {
            return cornerTemplate
            } else {
                return nil
            }
        case .graphicCircular:
            if UIImage(named: "Graphic Circular") != nil {
            return circularTemplate
            } else {
                return nil
            }
        case .circularSmall:
            return circularSmall
        default:
            return nil
        }
    }
    
    
    
    
} //classend
