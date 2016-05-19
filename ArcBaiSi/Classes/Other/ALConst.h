
#import <UIKit/UIKit.h>

typedef enum{
    ALTopicTypeAll = 1,
    ALTopicTypePicture = 10,
    ALTopicTypeWord=  29,
    ALTopicTypeVoice = 31,
    ALTopicTypeVideo = 41
} ALTopicType;

/**
 *  精华-顶部标题的高度
 */
UIKIT_EXTERN CGFloat const ALTitlesViewH;

/**
 *  精华-顶部标题的Y
 */
UIKIT_EXTERN CGFloat const ALTitlesViewY;

/**
 *  精华-cell-间距
 */
UIKIT_EXTERN CGFloat const ALTopicCellMargin;

/**
 *  精华-cell-文字内容的Y值
 */
UIKIT_EXTERN CGFloat const ALTopicCellTextY;

/**
 *  精华-cell-底部工具条的高度
 */
UIKIT_EXTERN CGFloat const ALTopicCellBottomBarH;

/**
 *  精华-cell-图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const ALTopicCellPictureMaxH;

/**
 *  精华-cell-图片帖子一旦超过最大高度，就是用Break
 */
UIKIT_EXTERN CGFloat const ALTopicCellPictureBreakH;