# YouTube URL Timestamp Remover
### [Install](https://raw.githubusercontent.com/RedSQL/personal-scripts-and-misc/master/userscripts/Youtube%20URL%20Timestamp%20Remover/tsremover.user.js)
## What is this?
This is a URL Timestamp remover from YouTube links. If you ever used a user timestamped feature on YouTube, you may know that YouTube attaches a `t=[SECONDS]s` as a URL parameter, which lets YouTube player determine and identify at which point video should be started. 

![URL Timestamp](https://i.vgy.me/zAMa6f.png)

This feature also is used when you click on video links that have a red bar below them.

![Like this](https://i.vgy.me/RpY5AJ.png)

## Why?
Sadly, from my experience, it's mostly inaccurate, which results in absolutely bogus timestamps that may be **MINUTES** behind. This userscript is a workaround since YouTube apparently stores 2 timestamps for a video. One is the one that issues `t=[SECONDS]s` URL parameter, and the other is the one that hotloads as you open the video. The one that hotloads as you open the video, from my personal experience, happened to be far more accurate in storing my progress in the video than the URL parameter issued one.
