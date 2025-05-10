//
//  LocalTVShowsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public final class LocalTVShowsRepository: TVShowsRepositoryProtocol {
    public init() {}

    public func getTVShows() async throws -> [TVShow] {
        return [
            .init(
                id: 1,
                name: "Under the Dome",
                type: "Scripted",
                language: "English",
                genres: ["Drama", "Science-Fiction", "Thriller"],
                status: "Ended",
                averageRuntime: 60,
                premiered: "2013-06-24",
                ended: "2015-09-10",
                officialSite: "http://www.cbs.com/shows/under-the-dome/",
                schedule: Schedule(
                    time: "22:00",
                    days: ["Thursday"]
                ),
                rating: Rating(average: 6.5),
                network: Network(
                    id: 2,
                    name: "CBS",
                    country: Country(
                        name: "United States",
                        code: "US",
                        timezone: "America/New_York"
                    ),
                    officialSite: "https://www.cbs.com/"
                ),
                webChannel: nil,
                image: ImageLinks(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
                ),
                summary: "Under the Dome is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome..."
            ),
            .init(
                id: 2,
                name: "The 100",
                type: "Scripted",
                language: "English",
                genres: ["Drama", "Action", "Science-Fiction"],
                status: "Ended",
                averageRuntime: 43,
                premiered: "2014-03-19",
                ended: "2020-09-30",
                officialSite: "http://www.cwtv.com/shows/the-100/",
                schedule: Schedule(
                    time: "21:00",
                    days: ["Wednesday"]
                ),
                rating: Rating(average: 7.6),
                network: Network(
                    id: 3,
                    name: "The CW",
                    country: Country(
                        name: "United States",
                        code: "US",
                        timezone: "America/New_York"
                    ),
                    officialSite: "https://www.cwtv.com/"
                ),
                webChannel: nil,
                image: ImageLinks(
                    medium: "https://static.tvmaze.com/uploads/images/medium_portrait/200/501942.jpg",
                    original: "https://static.tvmaze.com/uploads/images/original_untouched/200/501942.jpg"
                ),
                summary: "A century after Earth is devastated by nuclear war, a spaceship sends 100 young prisoners back to the planet to test its habitability, sparking a fight for survival and leadership."
            )
        ]

    }
    
    
}
