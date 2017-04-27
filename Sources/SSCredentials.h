#import <Foundation/Foundation.h>
#import "SSRequest.h"

/*!
 @protocol SSCredentials
 
 @brief The Credentials protocol
 
 @description Classes that implement the Credentials protocol 'sign' requests by adding SmartyStreets authentication keys.
 */
@protocol SSCredentials;

@interface SSCredentials : NSObject

@property (nonatomic, weak) id<SSCredentials> delegate;

@end

@protocol SSCredentials <NSObject>

- (void)sign:(SSRequest*)request;

@end

