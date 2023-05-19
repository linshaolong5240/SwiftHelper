//
//  CoreLocationDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/24.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct CoreLocationDemoView: View {
    @StateObject private var locationManager = SHLocationManager.shared
    
    var body: some View {
        List {
            Section {
                if let currentLocation = locationManager.currentLocation {
                    Group {
                        Text("current location: \(currentLocation)")
                        Text("coordinate: \(currentLocation.coordinate.longitude), \(currentLocation.coordinate.latitude)")
                        Text("altitude: \(currentLocation.altitude)")
                        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                            Text("ellipsoidalAltitude: \(currentLocation.ellipsoidalAltitude)")
                        }
                    }
                    Group {
                        Text("horizontalAccuracy: \(currentLocation.horizontalAccuracy)")
                        Text("verticalAccuracy: \(currentLocation.verticalAccuracy)")
                        Text("course: \(currentLocation.course)")
                        Text("courseAccuracy: \(currentLocation.courseAccuracy)")
                        Text("speed: \(currentLocation.speed)")
                        Text("timestamp: \(currentLocation.timestamp)")
                        Text("floor level: \(currentLocation.floor?.level.description ?? "nil")")
                        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                            Text("sourceInformation isProducedByAccessory: \(currentLocation.sourceInformation?.isProducedByAccessory.description ?? "nil")")
                            Text("sourceInformation isSimulatedBySoftware: \(currentLocation.sourceInformation?.isSimulatedBySoftware.description ?? "nil")")
                        }
                    }
                }
            } header: {
                Text("CLLocation")
            }
            
            Section {
                if let placemark = locationManager.currentPlacemark {
                    Group {
                        Text("current placemark: \(placemark)")
                        Text("location: \(placemark.location?.description ?? "nil")")
                        Text("region: \(placemark.region?.description ?? "nil")")
                        Text("timeZone: \(placemark.timeZone?.description ?? "nil")")
//                        'addressDictionary' was deprecated in macOS 10.13: Use @properties
//                        Text("addressDictionary: \(placemark.addressDictionary?.description ?? "nil")")
                    }
                    Group {
                        Text("name: \(placemark.name ?? "nil")")
                        Text("thoroughfare: \(placemark.thoroughfare ?? "nil")")
                        Text("subThoroughfare: \(placemark.subThoroughfare ?? "nil")")
                        Text("locality: \(placemark.locality ?? "nil")")
                        Text("subLocality: \(placemark.subLocality ?? "nil")")
                        Text("administrativeArea: \(placemark.administrativeArea ?? "nil")")
                        Text("subAdministrativeArea: \(placemark.subAdministrativeArea ?? "nil")")
                    }
                    
                    Group {
                        Text("postalCode: \(placemark.postalCode ?? "nil")")
                        Text("isoCountryCode: \(placemark.isoCountryCode ?? "nil")")
                        Text("country: \(placemark.country ?? "nil")")
                        Text("inlandWater: \(placemark.inlandWater ?? "nil")")
                        Text("ocean: \(placemark.ocean ?? "nil")")
                        if let areasOfInterest = placemark.areasOfInterest {
                            Text("areasOfInterest")
                            ForEach(Array(zip(areasOfInterest.indices, areasOfInterest)), id: \.0) { index, item in
                                Text(item)
                            }
                        } else {
                            Text("areasOfInterest: nil")
                        }
                    }
                }
            } header: {
                Text("CLPlacemark")
            }
        }
        .onAppear {
            locationManager.updateLocation()
        }

    }
}

#if DEBUG
struct CoreLocationDemoView_Previews: PreviewProvider {
    static var previews: some View {
        CoreLocationDemoView()
    }
}
#endif
