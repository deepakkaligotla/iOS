//
//  MainData.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 04/05/24.
//

import Foundation

enum UICategories: String, CaseIterable {
    case AllContent = "All Content"
    case Layout_Organisation = "Layout & Organisation"
    case Menu_Actions = "Menu & Actions"
    case Navigation_Search = "Navigation & Search"
    case AllPresentations = "All Presentations"
    case Selection_Input = "Selection & Input"
    case AllStatus = "All Status"
    case SystemExperiences = "System Experiences"
}

enum AllContent: String, CaseIterable {
    case Charts = "Charts"
    case ImageViews = "Image Views"
    case TextViews = "Text Views"
    case WebViews = "Web Views"
}

enum Layout_Organisation: String, CaseIterable {
    case Collections = "Collections"
    case Labels = "Labels"
    case Tables = "Tables"
    case SplitViews = "Split Views"
    case TabViews = "Tab Views"
}

enum Menu_Actions: String, CaseIterable {
    case ActivityViews = "Activity Views"
    case Buttons = "Buttons"
    case ContextMenus = "Context Menus"
    case EditMenus = "Edit Menus"
    case Menus = "Menus"
    case Toolbars = "Toolbars"
}

enum Navigation_Search: String, CaseIterable {
    case NavigationBars = "Navigation Bars"
    case SearchFields = "Search Fields"
    case SideBars = "Side Bars"
    case TabBars = "Tab Bars"
}

enum AllPresentations: String, CaseIterable {
    case ActionSheets = "Action Sheets"
    case Alerts = "Alerts"
    case PageControls = "Page Controls"
    case Popovers = "Pop overs"
    case ScrollViews = "Scroll Views"
    case Sheets = "Sheets"
}

enum AllStatus: String, CaseIterable {
    case ProgressIndicators = "Progress Indicators"
}

enum Selection_Input: String, CaseIterable {
    case ColorWells = "Color Wells"
    case Pickers = "Pickers"
    case SegmentedControls = "Segmented Controls"
    case Sliders = "Sliders"
    case Steppers = "Steppers"
    case TextFields = "Text Fields"
    case Toggles = "Toggles"
    case VirtualKeyboards = "Virtual Keyboards"
}

enum SystemExperiences: String, CaseIterable {
    case AppShortcuts = "App Shortcuts"
    case Complications = "Complications"
    case LiveActivities = "Live Activities"
    case TheMenuBar = "The Menu Bar"
    case Notifications = "Notifications"
    case StatusBars = "Status Bars"
    case TopShelf = "Top Shelf"
    case WatchFaces = "Watch Faces"
    case Widgets = "Widgets"
}

class UIData {
    static let totalUICount: Int = {
        let contentCount = AllContent.allCases.count
        let layoutCount = Layout_Organisation.allCases.count
        let menuCount = Menu_Actions.allCases.count
        let navigationCount = Navigation_Search.allCases.count
        let presentationsCount = AllPresentations.allCases.count
        let selectionCount = Selection_Input.allCases.count
        let statusCount = AllStatus.allCases.count
        let experiencesCount = SystemExperiences.allCases.count
        
        let totalCount = contentCount + layoutCount + menuCount + navigationCount + presentationsCount + selectionCount + statusCount + experiencesCount
        return totalCount
    }()
}
