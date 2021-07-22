//
//  JSON.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/1/21.
//

import Foundation

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome




struct Results: Codable {
    let type: String
    let route: Route
}


struct UserRoutes: Codable {
    let results: [RequestResult]
    let resultsCount: Int

    enum CodingKeys: String, CodingKey {
        case results
        case resultsCount = "results_count"
    }
}

// MARK: - Result
struct RequestResult: Codable {
    let id: Int


    enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - Route
struct Route: Codable {
    let id: Int

    let boundingBox: [BoundingBox]

    let trackPoints: [TrackPoint]
    
    let firstLongitudePoint: Double
    let firstLatitudePoint: Double
    let name: String


    enum CodingKeys: String, CodingKey {
        case id
        case name
        case boundingBox = "bounding_box"

        case trackPoints = "track_points"
        
        case firstLongitudePoint = "first_lng"
        
        case firstLatitudePoint = "first_lat"

    }
}

// MARK: - BoundingBox
struct BoundingBox: Codable {
    let lat, lng: Double
}

// MARK: - CoursePoint
//struct CoursePoint: Codable {
//    let d: Double
//    let coursePointDescription: String?
//    let i: Int
//    let n: String
//    let t: T
//    let x, y: Double
//    let e: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case d
//        case coursePointDescription = "description"
//        case i, n, t, x, y
//        case e = "_e"
//    }
//}

//enum T: String, Codable {
//    case tLeft = "Left"
//    case tRight = "Right"
//}

// MARK: - RouteMetrics
struct RouteMetrics: Codable {
    let id, parentID: Int
    let parentType: String
    let createdAt, updatedAt: Date
    let ele, grade: [String: Double]
    let distance, startElevation, endElevation: Double
    let numPoints: Int
    let eleGain, eleLoss: Double
    let v: Int
    let watts, cad, hr: CAD
    let hills: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case parentType = "parent_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ele, grade, distance, startElevation, endElevation, numPoints
        case eleGain = "ele_gain"
        case eleLoss = "ele_loss"
        case v, watts, cad, hr, hills
    }
}

// MARK: - CAD
struct CAD: Codable {
}

// MARK: - Photo
struct Photo: Codable {
    let id, groupMembershipID: Int
    let caption: String
    let createdAt: Date
    let position, visibility: Int
    let lat, lng: JSONNull?
    let published: Bool
    let capturedAt: JSONNull?
    let userID: Int
    let updatedAt: Date
    let width, height: Int
    let optionalUUID: JSONNull?
    let checksum: String

    enum CodingKeys: String, CodingKey {
        case id
        case groupMembershipID = "group_membership_id"
        case caption
        case createdAt = "created_at"
        case position, visibility, lat, lng, published
        case capturedAt = "captured_at"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case width, height
        case optionalUUID = "optional_uuid"
        case checksum
    }
}

// MARK: - PointsOfInterest
struct PointsOfInterest: Codable {
    let id: Int
    let lng, lat: Double
    let url: String?
    let mongoID: String?
    let parentID: Int
    let parentType: String
    let createdAt, updatedAt: Date
    let v, t: Int
    let n, d: String
    let pids: [JSONAny]
    let uid: Int

    enum CodingKeys: String, CodingKey {
        case id, lng, lat, url
        case mongoID = "mongo_id"
        case parentID = "parent_id"
        case parentType = "parent_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case v, t, n, d, pids, uid
    }
}

// MARK: - SegmentMatch
struct SegmentMatch: Codable {
    let id: Int
    let createdAt, updatedAt: Date
    let mongoID: String
    let userID, segmentID: Int
    let parentType: String
    let parentID: Int
    let finalTime: JSONNull?
    let visibility, startIndex, endIndex: Int
    let duration, movingTime, ascentTime, personalRecord: JSONNull?
    let vam, startedAt: JSONNull?
    let distance: Double
    let avgSpeed, rank: JSONNull?
    let segment: Segment
    let metrics: SegmentMatchMetrics

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mongoID = "mongo_id"
        case userID = "user_id"
        case segmentID = "segment_id"
        case parentType = "parent_type"
        case parentID = "parent_id"
        case finalTime = "final_time"
        case visibility
        case startIndex = "start_index"
        case endIndex = "end_index"
        case duration
        case movingTime = "moving_time"
        case ascentTime = "ascent_time"
        case personalRecord = "personal_record"
        case vam
        case startedAt = "started_at"
        case distance
        case avgSpeed = "avg_speed"
        case rank, segment, metrics
    }
}

// MARK: - SegmentMatchMetrics
struct SegmentMatchMetrics: Codable {
    let id, parentID: Int
    let parentType: String
    let createdAt, updatedAt: Date
    let ele, hr, cad: [String: Double]
    let speed: [String: Double]?
    let grade: [String: Double]
    let stationary: Bool?
    let duration, firstTime, movingTime, stoppedTime: Int?
    let pace, movingPace: Double?
    let ascentTime, descentTime: Int?
    let vam: Double?
    let tripSummary: [String: [Double]]?
    let hrZones: [String: Int]?
    let distance, startElevation, endElevation: Double
    let numPoints: Int
    let eleGain, eleLoss: Double
    let isClimb: Bool?
    let uciScore: Double?
    let uciCategory: Int?
    let fietsIndex: Double?
    let v: Int
    let watts: CAD
    let hills: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case parentType = "parent_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ele, hr, cad, speed, grade, stationary, duration, firstTime, movingTime, stoppedTime, pace, movingPace, ascentTime, descentTime, vam, tripSummary
        case hrZones = "hr_zones"
        case distance, startElevation, endElevation, numPoints
        case eleGain = "ele_gain"
        case eleLoss = "ele_loss"
        case isClimb, uciScore, uciCategory, fietsIndex, v, watts, hills
    }
}

// MARK: - Segment
struct Segment: Codable {
    let title, slug, toParam: String

    enum CodingKeys: String, CodingKey {
        case title, slug
        case toParam = "to_param"
    }
}

// MARK: - TrackPoint
struct TrackPoint: Codable {
    let e, x, y: Double
    let color, options: Int?
    
    enum CodingKeys: String, CodingKey {
//        case d
        case e
        case x
        case y
        case color, options
    }
 }


// MARK: - Encode/decode helpers



struct UserRoute: Codable {
    let id: Int
//    let createdAt: Date
//    let name: String
//    let distance, elevationGain, elevationLoss: Double
//    let locality: String?
//    let visibility: Int
//    let administrativeArea: AdministrativeArea?
//    let tagNames: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
//        case createdAt = "created_at"
//        case name, distance
//        case elevationGain = "elevation_gain"
//        case elevationLoss = "elevation_loss"
//        case locality, visibility
//        case administrativeArea = "administrative_area"
//        case tagNames = "tag_names"
    }
}

enum AdministrativeArea: String, Codable {
    case hi = "HI"
    case or = "OR"
    case wa = "WA"
}

//typealias UserRoutes = [UserRoute]



// MARK: - User
struct CurrentUser: Codable {
//    let id: Int
    
    let user: User
//    let labs: [String: Bool]
//    let additionalDrawerItems: [JSONAny]

//    let createdAt: Date
//    let userDescription, interests, locality, administrativeArea: String
//    let accountLevel: Int
//    let totalTripDistance: Double
//    let totalTripDuration: Int
//    let totalTripElevationGain: Double
//    let name: String
//    let highlightedPhotoID: Int
//    let highlightedPhotoChecksum: String

    enum CodingKeys: String, CodingKey {
//        case id
        case user
//        case labs
//        case additionalDrawerItems = "additional_drawer_items"
//        case createdAt = "created_at"
//        case userDescription = "description"
//        case interests, locality
//        case administrativeArea = "administrative_area"
//        case accountLevel = "account_level"
//        case totalTripDistance = "total_trip_distance"
//        case totalTripDuration = "total_trip_duration"
//        case totalTripElevationGain = "total_trip_elevation_gain"
//        case name
//        case highlightedPhotoID = "highlighted_photo_id"
//        case highlightedPhotoChecksum = "highlighted_photo_checksum"
    }
}


// MARK: - UserClass
struct User: Codable {
    let id: Int
//    let firstName, lastName, email: String
//    let createdAt: Date
//    let selfMembershipID: Int
//    let userDescription, interests: JSONNull?
//    let emailVisible: Bool
//    let lastLoginAt: Date
//    let totalRouteDistance: Int
//    let metricUnits: Bool
//    let hrMax, hrREST, hrZone1_Low, hrZone1_High: JSONNull?
//    let hrZone2_Low, hrZone2_High, hrZone3_Low, hrZone3_High: JSONNull?
//    let hrZone4_Low, hrZone4_High, hrZone5_Low, hrZone5_High: JSONNull?
//    let isMale: Bool
//    let weight, vo2Max: JSONNull?
//    let numUnreadMessages: Int
//    let lat, lng: Double
//    let displayName, locality, administrativeArea, postalCode: String
//    let countryCode: String
//    let emailOnMessage, emailOnComment, emailOnUpdate: Bool
//    let visibility: Int
//    let timeZone: String
//    let facebookID: JSONNull?
//    let accountLevel, weeksStartOn, emailBounceCount, tripsIncludedInTotalsCount: Int
//    let siteID: Int
//    let dob: JSONNull?
//    let deactivated: Int
//    let updatedAt: Date
//    let deactivatedAt: JSONNull?
//    let locale: String
//    let heatmapOptout, emailOnFollow, emailOnGoal: Bool
//    let name: String
//    let age: JSONNull?
//    let privileges: [String]
//    let highlightedPhotoID: Int
//    let preferences: Preferences
//    let gear: [JSONAny]
//    let unseenUpdates: [UnseenUpdate]
//    let pushApplications, relevantGoalParticipants, relevantChallengeParticipants: [JSONAny]
//    let hasChallengeParticipants: Bool
//    let clubIDS: [JSONAny]
//    let slimFavorites: [SlimFavorite]
//    let hasEvents, needsPasswordReset, eligibleForOnetimeTrial, isShadowUser: Bool
    let authToken: String
//    let userSummary: [String: [Double]]

    enum CodingKeys: String, CodingKey {
        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email
//        case createdAt = "created_at"
//        case selfMembershipID = "self_membership_id"
//        case userDescription = "description"
//        case interests
//        case emailVisible = "email_visible"
//        case lastLoginAt = "last_login_at"
//        case totalRouteDistance = "total_route_distance"
//        case metricUnits = "metric_units"
//        case hrMax = "hr_max"
//        case hrREST = "hr_rest"
//        case hrZone1_Low = "hr_zone_1_low"
//        case hrZone1_High = "hr_zone_1_high"
//        case hrZone2_Low = "hr_zone_2_low"
//        case hrZone2_High = "hr_zone_2_high"
//        case hrZone3_Low = "hr_zone_3_low"
//        case hrZone3_High = "hr_zone_3_high"
//        case hrZone4_Low = "hr_zone_4_low"
//        case hrZone4_High = "hr_zone_4_high"
//        case hrZone5_Low = "hr_zone_5_low"
//        case hrZone5_High = "hr_zone_5_high"
//        case isMale = "is_male"
//        case weight
//        case vo2Max = "vo2max"
//        case numUnreadMessages = "num_unread_messages"
//        case lat, lng
//        case displayName = "display_name"
//        case locality
//        case administrativeArea = "administrative_area"
//        case postalCode = "postal_code"
//        case countryCode = "country_code"
//        case emailOnMessage = "email_on_message"
//        case emailOnComment = "email_on_comment"
//        case emailOnUpdate = "email_on_update"
//        case visibility
//        case timeZone = "time_zone"
//        case facebookID = "facebook_id"
//        case accountLevel = "account_level"
//        case weeksStartOn = "weeks_start_on"
//        case emailBounceCount = "email_bounce_count"
//        case tripsIncludedInTotalsCount = "trips_included_in_totals_count"
//        case siteID = "site_id"
//        case dob, deactivated
//        case updatedAt = "updated_at"
//        case deactivatedAt = "deactivated_at"
//        case locale
//        case heatmapOptout = "heatmap_optout"
//        case emailOnFollow = "email_on_follow"
//        case emailOnGoal = "email_on_goal"
//        case name, age, privileges
//        case highlightedPhotoID = "highlighted_photo_id"
//        case preferences, gear
//        case unseenUpdates = "unseen_updates"
//        case pushApplications = "push_applications"
//        case relevantGoalParticipants = "relevant_goal_participants"
//        case relevantChallengeParticipants = "relevant_challenge_participants"
//        case hasChallengeParticipants = "has_challenge_participants"
//        case clubIDS = "club_ids"
//        case slimFavorites = "slim_favorites"
//        case hasEvents = "has_events"
//        case needsPasswordReset = "needs_password_reset"
//        case eligibleForOnetimeTrial = "eligible_for_onetime_trial"
//        case isShadowUser = "is_shadow_user"
        case authToken = "auth_token"
//        case userSummary = "user_summary"
    }
}

// MARK: - Preferences
//struct Preferences: Codable {
//    let defaultPrivacyTrip, defaultPrivacyRoute: Int
//    let metricUnits: Bool
//    let routePlannerDirectionsType: String
//    let routePlannerRightSidebarClosed, receiveSegmentNotifications, showDashOnboardingOverlay, plannerOnboardingDismissed: Bool
//    let plannerOverlay: String
//    let showCoursepointIcons, routePlannerLeftSidebarClosed: Bool
//    let facebook: Facebook
//    let defaultCareerInterval, smartExportState, routeViewerActiveSubtab: String
//
//    enum CodingKeys: String, CodingKey {
//        case defaultPrivacyTrip = "default_privacy_trip"
//        case defaultPrivacyRoute = "default_privacy_route"
//        case metricUnits = "metric_units"
//        case routePlannerDirectionsType = "route_planner_directions_type"
//        case routePlannerRightSidebarClosed = "route_planner_right_sidebar_closed"
//        case receiveSegmentNotifications = "receive_segment_notifications"
//        case showDashOnboardingOverlay = "show_dash_onboarding_overlay"
//        case plannerOnboardingDismissed = "planner-onboarding-dismissed"
//        case plannerOverlay = "planner_overlay"
//        case showCoursepointIcons = "show_coursepoint_icons"
//        case routePlannerLeftSidebarClosed = "route_planner_left_sidebar_closed"
//        case facebook
//        case defaultCareerInterval = "default_career_interval"
//        case smartExportState = "smart_export_state"
//        case routeViewerActiveSubtab = "route_viewer_active_subtab"
//    }
//}

// MARK: - Facebook
//struct Facebook: Codable {
//    let notifyOnActivity, notifyOnRoute: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case notifyOnActivity = "notify_on_activity"
//        case notifyOnRoute = "notify_on_route"
//    }
//}

// MARK: - SlimFavorite
//struct SlimFavorite: Codable {
//    let id: Int
//    let associatedObjectType: AssociatedObjectType
//    let associatedObjectID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case associatedObjectType = "associated_object_type"
//        case associatedObjectID = "associated_object_id"
//    }
//}

enum AssociatedObjectType: String, Codable {
    case route = "route"
}

// MARK: - UnseenUpdate
//struct UnseenUpdate: Codable {
//    let key: String
//    let count: Int
//}




