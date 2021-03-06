import XMonad
import XMonad.Hooks.DynamicLog
import System.Exit
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Config.Gnome
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Layout.Gaps
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutScreens
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Layout.TwoPane
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowArranger
import XMonad.Layout.Mosaic
import XMonad.Actions.PhysicalScreens
myBaseConfig = gnomeConfig

--{{{configuration
myWorkspaces = ["1:code", "2:web", "3:term", "4:irc", "5:gimp", "6:misc", "7:junk", "8:fullscreen", "9:im"]
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#D14836"

--screenWidth::Word32
--screenHeight::Word32
--midScreenWidth::Word32

--screenWidth = 1920 * 2
--screenHeight = 1080
--midScreenWidth = 1280


-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command --lock")

    , ((mod1Mask, xK_space               ), spawn "/usr/bin/synapse") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window


    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((mod1Mask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((mod1Mask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window

    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask .|. shiftMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- start a pomodoro
    , ((modMask              , xK_s     ), spawn "touch ~/.pomodoro_session")

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- toggle the status bar gap
    , ((modMask              , xK_b     ), sendMessage $ ToggleStruts) -- %! Toggle the status bar gap

    -- quit, or restart
    --, ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    --, ((modMask              , xK_q     ), spawn "xmonad --recompile && xmonad --restart") -- %! Restart xmonad

    -- media player

    , ((modMask, xK_c     ), spawn "banshee --toggle-playing") -- %! Pause banshee
    -- , ((modMask, xK_x     ), spawn "/home/minhajuddin/Dropbox/private/scripts/remove-current-song &> /tmp/log") -- %! Remove music from library
    , ((modMask, xK_v     ), spawn "banshee --next") -- %! next in banshee
    , ((modMask, xK_z     ), spawn "banshee --previous") -- %! previous in banshee

    -- gnome-do
    --, ((modMask, Space     ), spawn "gnome-do") -- %! gnome-do

    -- volume control
    , ((modMask, xK_m     ), spawn "amixer -c 1 -- sset Master playback 3%+") -- %! increase volume
    , ((modMask, xK_n     ), spawn "amixer -c 1 -- sset Master playback 3%-") -- %! decrease volume

    -- layout screens

    --1920 X 1080

    {-, ((modMask .|. shiftMask, xK_n), layoutScreens 2 $ fixedLayout [Rectangle 0 0 1920 (1080), Rectangle 1920 0 1920 1080])-}
    {-, ((modMask .|. shiftMask, xK_space), layoutScreens 3 $ fixedLayout [Rectangle 0 0 796 1080, Rectangle 796 0 1124 1080, Rectangle 1920 0 1920 1080])-}
    , ((modMask .|. shiftMask, xK_space), layoutScreens 3 $ fixedLayout [Rectangle 0 0 796 1200, Rectangle 796 0 1124 1200, Rectangle 1920 0 1920 1200])
    {-, ((modMask .|. shiftMask, xK_space), layoutScreens 3 $ fixedLayout [Rectangle 0 0 796 1080, Rectangle 796 0 1124 1080, Rectangle 1920 0 1920 1200])-}
    , ((modMask .|. shiftMask, xK_o), layoutScreens 3 $ fixedLayout [Rectangle 0 0 796 1080, Rectangle 796 0 1124 1080, Rectangle 1920 0 1920 1080])
    --, ((modMask .|. shiftMask, xK_space), layoutScreens 3 $ fixedLayout [Rectangle 0 0 1224 (1080), Rectangle 1224 0 (1920 - 1224) 1080, Rectangle 1920 0 1224 1080, Rectangle (1920 + 1224) 0 (1920 - 1224) 1080])
    --, ((modMask .|. shiftMask, xK_space), layoutScreens 3 $ fixedLayout [Rectangle 0 0 (screenWidth) (screenHeight), Rectangle screenWidth 0 midScreenWidth screenHeight, Rectangle (screenWidth + midScreenWidth) 0 (screenWidth - midScreenWidth) screenHeight])
    --screencast layout
    -- 1366x768
    -- OLD SETTINGS --, ((modMask .|. shiftMask, xK_s), layoutScreens 3 $ fixedLayout [Rectangle 0 0 1366 768, Rectangle 1366 0 (1920 - 1366) 1200, Rectangle 1920 0 1920 1200])
    -- , ((modMask .|. shiftMask, xK_s), layoutScreens 4 $ fixedLayout [Rectangle 0 0 1920 1200, Rectangle 1920 0 1366 768, Rectangle  (1920 + 1366) 0 (1920 - 1366) 1200, Rectangle 1920 768 1366 (1200-768)])
    , ((modMask .|. shiftMask, xK_s), layoutScreens 3 $ fixedLayout [Rectangle 0 0 1920 1200, Rectangle 1920 0 1366 768, Rectangle  (1920 + 1366) 0 (1920 - 1366) 1200, Rectangle 1920 768 1366 (1200-768)])
    , ((modMask .|. controlMask .|. shiftMask, xK_space), rescreen)

    -- misc control
    --, ((modMask, xK_x     ), spawn "nautilus") -- %! open nautilus


    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++
    ---- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    ---- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
     --[((m .|. modMask, key), f sc)
         -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
         --, (f, m) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]
         -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
       -- [((modm .|. mask, key), f sc)
           -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
           -- , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

myLayout = onWorkspace "5:gimp" gimp $
           onWorkspace "3:term"  htiled $
           onWorkspace "9:im"  htiled $
           onWorkspace "8:fullscreen"  (noBorders Full) $
    avoidStruts $ toggleLayouts (noBorders Full)
    (Full ||| tiled ||| mosaic 2 [3,2] ||| Mirror tiled)
    where
        tiled   =  ResizableTall nmaster delta ratio []
        htiled = avoidStruts $ Tall hmaster delta ratio
        hmaster = 8
        nmaster = 1
        delta   = 2/100
        ratio   = 1/2
        gimp    =  withIM (0.11) (Role "gimp-toolbox") $
                   reflectHoriz $
                   withIM (0.15) (Role "gimp-dock") Full

--}}}configuration

--fullscreenLayout = named "fullscreen" $ noBorders Full

myManageHook = composeAll
    [
          className =? "Vncviewer" --> doFloat
        , className =? "Screenkey" --> doIgnore
        , className =? "screenkey" --> doIgnore
        , className =? "synapse" --> doIgnore
        , className =? "Synapse" --> doIgnore
        , className =? "Do" --> doIgnore
        , className =? "Hangouts" --> doIgnore
        , className =? "Firefox"   --> doF (W.shift "6:misc")
        , className =? "Banshee"   --> doF (W.shift "6:misc")
        , className =? "Skype"     --> doF (W.shift "9:im")
        , className =? "Pidgin"    --> doF (W.shift "9:im")
    ]

main = do
    xmproc <- spawnPipe "/home/minhajuddin/.cabal/bin/xmobar"
    xmonad $ myBaseConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook myBaseConfig
        , layoutHook = myLayout
        , handleEventHook    = fullscreenEventHook
        , keys = myKeys
        , workspaces         = myWorkspaces
        , startupHook = setWMName "LG3D"
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        -- , focusFollowsMouse  = True
        }

