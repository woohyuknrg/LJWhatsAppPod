//
//  LJWhatsAppPod.h
//  LJWhatsAppPod
//
//  Created by ray on 2018/7/21.
//  Copyright © 2018年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for LJWhatsAppPod.
FOUNDATION_EXPORT double LJWhatsAppPodVersionNumber;

//! Project version string for LJWhatsAppPod.
FOUNDATION_EXPORT const unsigned char LJWhatsAppPodVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LJWhatsAppPod/PublicHeader.h>

@class WAWebPageMetadata;

@interface WAMessage

@property(nonatomic) BOOL isFromMe;

@property(copy, nonatomic) NSString *text;

@end

@interface WAWebPageFromTextLoader

@property(copy, nonatomic) NSString *text;

@end

@interface WAChatStorage

//- (void)sendMessageWithText:(id)arg1 metadata:(id)arg2 toChatSessions:(id)arg3 hasTextFromURL:(_Bool)arg4;

- (id)sendMessageWithText:(id)arg1 metadata:(id)arg2 multicast:(_Bool)arg3 replyingToMessage:(id)arg4 quotingChatSession:(id)arg5 inChatSession:(id)arg6 hasTextFromURL:(_Bool)arg7 openedFromURL:(_Bool)arg8;

@end

@interface WAChatSession

@property(readonly, nonatomic) WAChatStorage *chatStorage;

@end

@interface WAChatMessageInputView

@property(retain, nonatomic) WAWebPageMetadata *webPageMetadata;
@property(retain, nonatomic) WAMessage *quotedMessage;
@property(retain, nonatomic) WAChatSession *quotedChatSession;

- (void)didSendMessage;

@end

@interface WAChatViewController

@property(readonly, nonatomic) WAChatMessageInputView *chatMessageInputView;
@property(readonly, nonatomic) WAChatSession *chatSession;
@property(nonatomic) _Bool openedFromURL;
@property(nonatomic) _Bool hasTextFromURL;

- (void)chatMessageInputView:(WAChatMessageInputView*)inputView userDidSubmitText:(NSString*)text metadata:(id)arg3 completion:(void (^)(BOOL))arg4;

- (void)transactionDidProcessMessages:(NSNotification*)notify;

@end
