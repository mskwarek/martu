{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-missing-signatures #-}

-- hackage docs: http://hackage.haskell.org/package/xmonad-contrib-0.16/docs/

module Main (main) where

import XMonad
import XMonad.Actions.CycleWS(nextScreen)

import XMonad.Hooks.DynamicBars
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.NoBorders(noBorders, smartBorders)
import XMonad.Layout.Renamed

import XMonad.StackSet(focusDown, focusUp)

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce(spawnOnce)

-- super key
myMod = mod4Mask

-- terminal
myTerminal = "lxterminal --command tmux"

-- Colors
color :: String -> String
color "black"       = "#0E0D0B"
color "light-black" = "#686250"
color "white"       = "#FFFFFF"
color "gray"        = "#dddddd"
color "red"         = "#FE7246"
color "green"       = "#43A047"
color "yellow"      = "#FE9D4D"
color "blue"        = "#83A598"
color "magenta"     = "#D73570"
color "cyan"        = "#83A5B3"
color "orange"      = "#FE8019"
color "salmon"      = "#D7875F"
color _             = "#28241F"

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["1:λ", "2:dev", "3", "4", "5", "6", "7", "8", "9"]

main :: IO ()
main = xmonad $ def
  { modMask            = myMod
  , terminal           = myTerminal
  , normalBorderColor  = color "light-black"
  , focusedBorderColor = color "white"
  , borderWidth        = 1
  , workspaces         = myWorkspaces
  , manageHook         = myManageHook
  , layoutHook         = myLayoutHook
  , handleEventHook    = myHandleEventHook
  , logHook            = myLogHook
  , startupHook        = myStartupHook
  } `additionalKeysP` myKeybinds

myScreenID (S sid) = spawnPipe $ "xmobar -x " ++ (show sid) ++ " ~/.xmonad/xmobar.hs"

myHandleEventHook = handleEventHook def
                    <+> docksEventHook <+>
                    (dynStatusBarEventHook myScreenID $ return ())

myStartupHook = do
  spawnOnce "~/.xmonad/scripts/init"
  spawn "~/.xmonad/scripts/start"
  dynStatusBarStartup myScreenID $ return ()

myKeybinds = [ ("M-d"                    , spawn "~/.xmonad/scripts/dmenu-run")
             , ("M-<U>"                  , spawn amixerVolUp)
             , ("M-<D>"                  , spawn amixerVolDown)
             , ("M-S-m"                  , spawn amixerToggle)
             , ("<XF86AudioRaiseVolume>" , spawn amixerVolUp)
             , ("<XF86AudioLowerVolume>" , spawn amixerVolDown)
             , ("<XF86AudioMute>"        , spawn amixerToggle)
             , ("M-q"                    , spawn "xmonad --restart")
             , ("M-o"                    , nextScreen)
             , ("M-p"                    , windows focusUp)
             , ("M-n"                    , windows focusDown)
             , ("M-C-l"                  , spawn "i3lock -c 000000")
             ]
             where
               amixerVolUp   = "amixer set Master 2%+"
               amixerVolDown = "amixer set Master 2%-"
               amixerToggle  = "amixer set Master toggle"

myLayoutHook = avoidStruts $
               smartBorders $
               renamed [Replace "tall"] (Tall 1 (2/100) (1/2)) |||
               renamed [Replace "full"] (noBorders Full)

myManageHook = manageHook def <+> composeAll
  [ className =? "Gimp"    --> doFloat
  , className =? "firefox" --> doShift "2"
  , className =? "mpv"     --> (doShift "3" <+> doFloat)
  , isFullscreen           --> doFullFloat
  ]

myXmobarPP xs = xmobarPP { ppTitle   = xmobarColor xs "" . shorten 60
                         , ppSep     = " <fc=#292723>|</fc> "
                         , ppLayout  = xmobarColor xs ""
                         , ppCurrent = xmobarColor xs "" . ("[" ++) . (++ "]")
                         }

myLogHook = multiPP (myXmobarPP $ color "white") (myXmobarPP $ color "white")
