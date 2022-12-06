import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.StackSet
import XMonad.Layout.Groups.Helpers
import System.IO
import Data.Monoid
import Control.Monad
import qualified Data.Map as M


import System.IO.Unsafe


fixFloatsEventHook :: Event -> X All
fixFloatsEventHook (CrossingEvent {ev_event_type=t, ev_window=w} )
      | t == enterNotify = do
            fs <- gets $ M.keys . floating . windowset
            when (any (==w) fs) $ windows $ (insertUp w) . (delete' w)
            return $ All True
      | otherwise = return $ All True
fixFloatsEventHook _ = return $ All True

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ docks $ def {
      --terminal = "xfce4-terminal",
      terminal = "alacritty",
      modMask  = mod4Mask,
      borderWidth = 1,
      manageHook = composeAll [isFullscreen --> doFullFloat, className =? "mpv" --> doFloat] <+> manageDocks <+> manageHook def,
      layoutHook = smartBorders $ avoidStruts  $  layoutHook def,
      handleEventHook = fixFloatsEventHook <+> handleEventHook def,
      logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc,
                          ppTitle = xmobarColor "green" "" . shorten 150
                        }

    } `additionalKeys`
     [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
       ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
       ((0, xK_Print), spawn "scrot")
     ]
