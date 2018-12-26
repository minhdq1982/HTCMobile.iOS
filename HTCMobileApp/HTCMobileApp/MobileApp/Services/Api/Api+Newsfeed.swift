//
//  Api+Newsfeed.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Api {
    public func getYoutubeFeed(maxResults: Int, nextToken: String) -> RequestProtocol {
        var params = "key=\(Constants.googleAPIKey)&channelId=\(Constants.youtubeChannelId)&part=snippet,id&order=date&maxResults=\(maxResults)"
        if !nextToken.isEmpty {
            params = "key=\(Constants.googleAPIKey)&channelId=\(Constants.youtubeChannelId)&part=snippet,id&order=date&maxResults=\(maxResults)&pageToken=\(nextToken)"
        }
        return YoutubeRequest(getParams: params)
    }
    
    public func getFacebookFeed(maxResults: Int, after: String) -> RequestProtocol {
        
        var params = "fields=\(Constants.facebookFields)&access_token=\(Constants.facebooPageToken)&limit=\(maxResults)"
        if !after.isEmpty {
            params = "fields=\(Constants.facebookFields)&access_token=\(Constants.facebooPageToken)&limit=\(maxResults)&after=\(after)"
        }
        return FacebookRequest(getParams: params)
    }
}
