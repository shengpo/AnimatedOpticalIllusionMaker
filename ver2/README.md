AnimatedOpticalIllusionMaker 2
==============================

try to use Processing to make an animated optical illusion<br/>
嘗試使用Processing做出animated optical illusion效果

using easier way to create your own animated optical illusion, just like the way you write Processing sketch as usual.<br/>
使用更簡單的方式來創造自己的 animated optical illusion, 就像平常寫Processing一樣。

demo video: http://youtu.be/sfQP6yzejXs


NOTE：
------
- template code is in the folder `template_code`
- example codes are in the folder `example_code`


簡單說明：
---------
####柵欄(stripes)設定要領：
- 柵欄寬度( `stripeBlackWidth` ) 不要過大，太大不好看。
- 柵欄間隔( `stripeGapWidth` ) 跟柵欄寬度不要相差太多，相差太多會造成illusion效果不好。

####Animation製作要領：
- 盡量在很少的影格中完成想要的動畫，這樣效果較好
- 動畫的影格數最好跟 `illusionFrameCount` 一樣

####操作說明：
- 按 `s` 是開啟/關閉柵欄(stripes)
- 按 `空白鍵` 是產生預覽的optical illusion圖案, 以及optical illusion圖案的PDF檔，以及柵欄(stripes)的PDF檔 (位於 `pdf資料夾` 下)
- 按 `i` 是開啟/關閉所產生的optical illusion圖案 (需先按 `空白鍵` 產生optical illusion圖案)


simple instructions:
--------------------
####tips of setting stripes:
- let the `stripeBlackWidth` in suitable value, not too much. big value makes bad look.
- let the difference of `stripeBlackWidth` and `stripeGapWidth` in suitable value. big difference makes bad effect of illusion.

####tips of making animation:
- less frames of animation can produce better effect
- it is better to make the total count of frames is the same with `illusionFrameCount`

####description of operation for this sketch:
- press `s` : to switch on/off stripes
- press `SPACE` : to produce optical illusion image for preview, and also produce the PDF files of optical illusion image and stripes (under directory named `pdf`) 
- press `i` : to switch on/off optical illusion image for preview (need to press `SPACE` first to produce optical illusion image)

