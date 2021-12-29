import XMonad
import XMonad.Hooks.DynamicLog
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig

import System.IO

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
   modMask       = mod4Mask
 , terminal      = "urxvt"
 , borderWidth   = 2
} `additionalKeysP` myKeys
myKeys =  [ ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
            , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
            , ("<XF86AudioMute>", spawn "amixer set Master toggle")    

            , ("<XF86AudioPlay>", spawn "playerctl play-pause")    
            , ("<XF86AudioPrev>", spawn "playerctl previous")    
            , ("<XF86AudioNext>", spawn "playerctl next")    

            , ("<XF86MonBrightnessUp>", spawn "lux -a 5%")    
            , ("<XF86MonBrightnessDown>", spawn "lux -s 5%")    
            ]
