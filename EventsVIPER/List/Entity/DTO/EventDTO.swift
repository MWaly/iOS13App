//
//  Event.swift
//  EventsVIPER


import Foundation

struct EventDTO: Codable {
    let id: String
    let name: String
    let localDate: String
    let localTime: String
    let yesRsvpCount: Int
    let group: Group
}

struct Group: Codable {
    let name: String
}
