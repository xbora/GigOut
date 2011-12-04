//
//  Constants.h
//  UberLife
//
//  Created by Richard on 12/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define URL_ENDPOINT @"http://stealth.uberlife.com/api/v1"


#define UBERLIFE_DELEGATE  ((UberLifeAppDelegate*)[[UIApplication sharedApplication] delegate])

#define ACTIVITIES_PATH             @"/activities"
#define ACTIVITY_STREAM_PATH        @"/activity_stream"
#define CHECKIN_PATH                @"/hangouts/--id--/checkin"
#define COMMENT_PATH                @"/comments"
#define CONNECTORS                  @"/connectors"
#define DELETE_RSVP_PATH            @"/hangouts/--id--/attendance"
#define FOLLOW_PATH                 @"/followings"
#define FRIENDS_WITH_INVITES_PATH   @"/invites/friends_with_invites"
#define GET_MY_SOCIALS_PATH         @"/my_socials"
#define GUEST_LIST_OPTION_PATH      @"/guest_list_options"
#define GUEST_LIST_PATH             @"/guest_list"
#define HOST_REVIEW_PATH            @"/hosts/reviews"
#define HUMOURTYPE_LIST_PATH        @"/humor_types"
#define INTERESTS_LIST_PATH         @"/interests"
#define INVITE_PATH                 @"/invites"
#define INVITES_REQUESTS_PATH       @"/invite_requests"
#define LOCATION_SEARCH_PATH        @"/locations/search"
#define MESSEGES_PATH               @"/messages"
#define MY_PEOPLE_PATH              @"/my_people"
#define ORIENTATION_TYPES_PATH      @"/orientations"
#define PERMISIONS_PATH             @"/facebook/permissions"
#define PHOTO_PATH                  @"/photos"
#define PRODUCTS_PATH               @"/products"
#define RECEIPT_VARIFICATION        @"/transaction_verifications"
#define REGISTER_PATH               @"/users"
#define RELATIONSHIP_TYPES_PATH     @"/relationship_types"
#define REVIEW_PATH                 @"/reviews"
#define RSVP_SOCIAL_PATH            @"/hangouts/--id--/attendance"
#define RSVP_TYPES_PATH             @"/rsvp_notification_options"
#define SOCIAL_AGERANGE_PATH        @"/social_age_ranges"
#define SOCIAL_CATEGORIES_PATH      @"/hangout_categories"
#define SOCIAL_COMMENTING_PATH      @"/hangout_commenting_options"
#define SOCIAL_GENDERS_PATH         @"/hangout_genders"
#define SOCIAL_IMAGE_PATH           @"/hangouts/--id--/photos"
#define SOCIALS_PATH                @"/hangouts"
#define SOCIALS_NEARBY_PATH         @"/hangouts/nearby"
#define SOCIALS_RECOMMENDED_PATH    @"/hangouts/recommended"
#define SOCIAL_RELATIONSHIPS_PATH   @"/relationship_type_categories"
#define SOCIAL_REVIEW_PATH          @"/hangouts/--id--/reviews"
#define UBERFRIENDS_PATH            @"/friends"
#define USER_DETAILS_PATH           @"/users/--id--"
#define USER_ACTIVITY_PATH          @"/users/%@/activities"
#define USER_PHOTOS_PATH            @"/users/--id--/photos"
#define VENUES_PATH                 @"/venues"
#define WAIT_LIST_PATH              @"/wait_list"

#define UBERLIFE_DARK_BACKGROUND_COLOR  [UIColor colorWithWhite:0.835f alpha:1.0f]
#define UBERLIFE_TABLE_COLOR            [UIColor colorWithWhite:0.972f alpha:1.0f]
#define UBERLIFE_BACKGROUND_COLOR       [UIColor colorWithRed:0.988f green:0.996f blue:0.941f alpha:1.0f]
#define UBERLIFE_NAVBAR_COLOR           [UIColor colorWithRed:250.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0f]

#define SEND_INVITE_SUCCESS                     @"SendingInviteSuccess"
#define SEND_INVITE_FAIL                        @"SendingInviteFail"
#define DELETE_INVITE_REQUEST_SUCCESS           @"DeleteInviteRequestSuccess"
#define DELETE_INVITE_REQUEST_FAIL              @"DeleteInviteRequestFail"
#define FOLLOW_FREENDS_FINISHED                 @"FollowFriendsFinished"
#define USER_AUTHENTICATED_WITH_FACEBOOK        @"UserAuthenticatedWithFacebook"
#define USER_AUTHENTICATED_WITH_TWITTER         @"UserAuthenticatedWithTwitter"
#define USER_REGISTERED_NOTIFICATION            @"UserRegisteredNotification"
#define USER_HAS_NO_INVITE_NOTIFICATION         @"UserHasNoInviteNotification"
#define USER_FAILED_REGISTRATION                @"UserFailedRegistration"
#define USER_HAS_NO_UBERFRIENDS_NOTIFICATION    @"UserHasNoUberFriendsNotification"
#define USER_SUCCESSFULLY_AUTHENTICATED         @"UserSuccessfullyAuthenticated"
#define USER_FAILED_AUTHENTICATION              @"UserFailedAuthentication"
#define USER_LOCAL_REFRESHED                    @"UserLocalRefreshed"
#define SOCIAL_CREATED                          @"SocialCreated"
#define SOCIAL_DELETED                          @"SocialDeleted"
#define SOCIAL_NOT_CREATED                      @"SocialNotCreated"
#define USER_RSVPED_SOCIAL                      @"UserDidRSVPToASocial"
#define GET_MY_SOCIALS_FINISHED                 @"GetMySocialFinished"
#define SOCIALSLISTNEEDSTOBEREFRESHED           @"SocialsListNeedsToBeRefreshed"


#define NULL_NIL(val) val != [NSNull null] ? val : nil
#define DICT_GET(_DICT, _KEY) NULL_NIL([_DICT objectForKey:_KEY])
#define DICT_GET_INT(_DICT, _KEY) [DICT_GET(_DICT, _KEY) intValue]
#define STRETCHIMAGE(x,y,z) ([[UIImage imageNamed: [NSString stringWithFormat:@"%@", (x)]] stretchableImageWithLeftCapWidth:(y) topCapHeight:(z)])


