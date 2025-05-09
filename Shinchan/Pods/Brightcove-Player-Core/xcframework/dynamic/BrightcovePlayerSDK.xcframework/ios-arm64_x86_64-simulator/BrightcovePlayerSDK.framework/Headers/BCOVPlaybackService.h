//
// BCOVPlaybackService.h
// BrightcovePlayerSDK
//
// Copyright (c) 2023 Brightcove, Inc. All rights reserved.
// License: https://accounts.brightcove.com/en/terms-and-conditions
//

#import <Foundation/Foundation.h>

#import <BrightcovePlayerSDK/BCOVCuePoint.h>
#import <BrightcovePlayerSDK/BCOVPlaylist.h>
#import <BrightcovePlayerSDK/BCOVSource.h>
#import <BrightcovePlayerSDK/BCOVVideo.h>

@class BCOVPlaybackServiceRequestFactory;

/**
 * Errors associated with Playback API requests.
 */
typedef NS_ENUM(NSInteger, BCOVPlaybackServiceErrorCode)
{
    /**
     * No error.
     */
    BCOVPlaybackServiceErrorNoError,

    /**
     * Error Code that indicates there was an error connecting to the Playback
     * API. Check the error.userInfo key NSUnderlyingErrorKey for the actual
     * connection error.
     */
    BCOVPlaybackServiceErrorCodeConnectionError,

    /**
     * Error Code that indicates there was an error parsing the response as JSON.
     * If the request returned any data, that raw NSData will be included in the
     * userInfo by key kBCOVPlaybackServiceErrorKeyRawResponseData. Check the
     * error.userInfo key NSUnderlyingErrorKey for the actual JSON deserialization error.
     */
    BCOVPlaybackServiceErrorCodeJSONDeserializationError,

    /**
     * Error Code that indicates there was an error returned by the API. Check the
     * error.userInfo key kBCOVPlaybackServiceErrorKeyAPIErrors for an NSArray
     * of errors returned by the API and key kBCOVPlaybackServiceErrorKeyAPIHTTPStatusCode
     * to find the status code returned.
     */
    BCOVPlaybackServiceErrorCodeAPIError
};


/**
 * Error domain for BCOVPlaybackService.
 */
extern NSString * const kBCOVPlaybackServiceErrorDomain;

/**
 * Key for NSError.userInfo for errors with domain kBCOVPlaybackServiceErrorDomain
 * and errorCode BCOVPlaybackServiceErrorCodeJSONDeserializationError. This is the
 * raw response data. This may not exist in error.userInfo.
 */
extern NSString * const kBCOVPlaybackServiceErrorKeyRawResponseData;

/**
 * Key for NSError.userInfo for errors with domain kBCOVPlaybackServiceErrorDomain
 * and errorCode BCOVPlaybackServiceErrorCodeAPIError. This is an NSArray of errors
 * returned by the Playback API.
 */
extern NSString * const kBCOVPlaybackServiceErrorKeyAPIErrors;

/**
 * Key for NSError.userInfo for errors with domain kBCOVPlaybackServiceErrorDomain
 * and errorCode BCOVPlaybackServiceErrorCodeAPIError. This is the HTTP status code
 * returned by the API request.
 */
extern NSString * const kBCOVPlaybackServiceErrorKeyAPIHTTPStatusCode;


/**
 * Playlist Paging dictionary keys
 *
 * For BCOVPlaybackService methods that return a playlist, you can request a
 * partial playlist, or "pages" from the playlist by specifying a limit and offset.
 *
 * For example, if you have a playlist with 100 videos, you can request
 * only 6 videos starting at video number 10 with the following parameters
 * dictionary:
 *
 *     NSDictionary *parameters =
 *     @{
 *         @"limit": @6,
 *         @"offset": @10
 *     };
 */

/**
 * Parameter dictionary key for BCOVPlaybackService methods that return a playlist.
 * This key sets the maximum number of videos returned in a playlist.
 * This constant can be used in place of the string value "limit".
 */
extern NSString * const kBCOVPlaybackServiceParameterKeyLimit;

/**
 * Parameter dictionary key for BCOVPlaybackService methods that return a playlist.
 * This key sets the starting index into the playlist at which videos will be returned.
 * This constant can be used in place of the string value "offset".
 */
extern NSString * const kBCOVPlaybackServiceParameterKeyOffset;

/**
 * Parameter dictionary key for BCOVPlaybackService methods that return a playlist or video.
 * This key sets the SSAI ad config ID.
 * This constant can be used in place of the string value "ad_config_id".
 */
extern NSString * const kBCOVPlaybackServiceParamaterKeyAdConfigId;

/**
 * Parameter dictionary key for BCOVPlaybackService methods that return a playlist or video.
 * This key enables Dynamic Delivery Rules for just-in-time manifest generation.
 * This constant can be used in place of the string value "config_id".
 */
extern NSString * const kBCOVPlaybackServiceParameterKeyDeliveryConfigId;


/**
 * The BCOVPlaybackService class provides asynchronous methods for retrieving 
 * information about videos from Brightcove’s Playback API.
 */
@interface BCOVPlaybackService : NSObject

/**
 * NSURLSession shared across all network calls to the BCOVPlaybackService.
 * This object is created when the Playback Service is initialized.
 * If you wish to use your own NSURLSession you can set it here.
 * If set to nil, the default NSURLSession will be re-created.
 */
@property (nonatomic, strong) NSURLSession *sharedURLSession;

/**
 * The watermarking token for use with Forensic Watermarking
 */
@property (nonatomic, copy) NSString *watermarkingToken;

/**
 * Initializes a BCOVPlaybackService. It uses the accountId and policyKey
 * to create a BCOVPlaybackServiceRequestFactory internally.
 *
 * If using the Edge Playback Service, the policyKey value should be nil
 *
 *
 * @param accountId Account Id to be used for each request. Must not be nil.
 * @param policyKey PolicyKey to be used for each request. May be nil.
 * @return An initialized instance.
 */
- (instancetype)initWithAccountId:(NSString *)accountId policyKey:(NSString *)policyKey;

/**
 * Initializes a BCOVPlaybackService with a required BCOVPlaybackServiceRequestFactory.
 *
 * @param requestFactory Request Factory to use for creating URL requests.
 * @return An initialized instance.
 */
- (instancetype)initWithRequestFactory:(BCOVPlaybackServiceRequestFactory *)requestFactory NS_DESIGNATED_INITIALIZER;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its playlist ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param playlistID The ID of the playlist to find.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithPlaylistID:(NSString *)playlistID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its playlist ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param playlistID The ID of the playlist to find.
 * @param bumperID The ID of the bumper video.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithPlaylistID:(NSString *)playlistID bumperID:(NSString *)bumperID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its playlist ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param playlistID The ID of the playlist to find.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithPlaylistID:(NSString *)playlistID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its playlist ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param playlistID The ID of the playlist to find.
 * @param bumperID The ID of the bumper video.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithPlaylistID:(NSString *)playlistID bumperID:(NSString *)bumperID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its reference ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param parameters Additional NSString query parameters to add to the Playback
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithReferenceID:(NSString *)referenceID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its reference ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param bumperReferenceID The reference ID of the bumper video.
 * @param parameters Additional NSString query parameters to add to the Playback
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithReferenceID:(NSString *)referenceID bumperReferenceID:(NSString *)bumperReferenceID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its reference ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithReferenceID:(NSString *)referenceID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVPlaylist from the Playback API service by its reference ID on a
 * background queue.
 *
 * If the completionHandler provides an NSError, the BCOVPlaylist will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param bumperReferenceID The reference ID of the bumper video.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * Can use the kBCOVPlaybackServiceParameterKeyOffset and kBCOVPlaybackServiceParameterKeyLimit
 * parameters. See "Playlist Paging" above.
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findPlaylistWithReferenceID:(NSString *)referenceID bumperReferenceID:(NSString *)bumperReferenceID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its video ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param videoID The ID of the video to find.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithVideoID:(NSString *)videoID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its video ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param videoID The ID of the video to find.
 * @param bumperID The ID of the bumper video.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithVideoID:(NSString *)videoID bumperID:(NSString *)bumperID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its video ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param videoID The ID of the video to find.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithVideoID:(NSString *)videoID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its video ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param videoID The ID of the video to find.
 * @param bumperID The ID of the bumper video.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithVideoID:(NSString *)videoID bumperID:(NSString *)bumperID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its reference ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithReferenceID:(NSString *)referenceID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its reference ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param bumperReferenceID The reference ID of the bumper video.
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithReferenceID:(NSString *)referenceID bumperReferenceID:(NSString *)bumperReferenceID parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its reference ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithReferenceID:(NSString *)referenceID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;

/**
 * Retrieves a BCOVVideo from the Playback API service by its reference ID on a background
 * queue.
 *
 * If the completionHandler provides an NSError, the BCOVVideo will be nil.
 *
 * @param referenceID The reference ID of the video to find.
 *  @param bumperReferenceID The reference ID of the bumper video.
 * @param authToken The authorization token with which to validate the video's license
 * @param parameters Additional NSString query parameters to add to the Playback
 * API requests. These values will override the default values if they conflict.
 * @param completionHandler block which will be invoked when the request
 * finishes. Execution of the completionHandler will occur on the main thread.
 */
- (void)findVideoWithReferenceID:(NSString *)referenceID bumperReferenceID:(NSString *)bumperReferenceID authToken:(NSString *)authToken parameters:(NSDictionary *)parameters completion:(void (^)(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error))completionHandler;


/**
 * Initializes a source from the JSON dictionary. Properties that don't map to
 * first class properties on the source are added to the properties dictionary.
 *
 * @param json Dictionary representing the deserialized source.
 * @return The initialized source.
 */
+ (BCOVSource *)sourceFromJSONDictionary:(NSDictionary *)json;

/**
 * Initializes a cue point from the JSON dictionary. Properties that don't
 * map to first class properties on cue point are added to the properties
 * dictionary.
 *
 * @param json Dictionary representing the deserialized cuepoint.
 * @return The initialized cue point.
 */
+ (BCOVCuePoint *)cuePointFromJSONDictionary:(NSDictionary *)json;

/**
 * Initializes a playlist from the JSON dictionary. Properties that don't
 * map to first class properties on playlist are added to the properties
 * dictionary.
 *
 * @param json Dictionary representing the deserialized playlist.
 * @return The initialized playlist.
 */
+ (BCOVPlaylist *)playlistFromJSONDictionary:(NSDictionary *)json;

/**
 * Initializes a video from the JSON dictionary. Properties that don't
 * map to first class properties on video are added to the properties
 * dictionary.
 *
 * @param json Dictionary representing the deserialized video.
 * @return The initialized video.
 */
+ (BCOVVideo *)videoFromJSONDictionary:(NSDictionary *)json;

@end
