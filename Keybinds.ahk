#Requires AutoHotkey v2.0

; Alt + B to open Microsoft Edge
!b::
{
    Run "msedge.exe"
}

; Alt + RETURN to open powershell
!Enter::
{
    Run "powershell.exe"
}

!e::
{
    Run "explorer.exe"
}

; Alt + Mouse Wheel Up to increase Opacity
!<+WheelUp::
{
    try {
        currentTrans := WinGetTransparent("A")
        if (currentTrans = "")
            currentTrans := 255
        
        newTrans := Min(currentTrans + 5, 255)
        WinSetTransparent(newTrans, "A")
        ToolTip("Opacity: " . Round((newTrans / 255) * 100) . "%")
        SetTimer () => ToolTip(), -1000 ; Hide after 1 second
    }
}

; Alt + Mouse Wheel Down to decrease Opacity
!<+WheelDown::
{
    try {
        currentTrans := WinGetTransparent("A")
        if (currentTrans = "")
            currentTrans := 255
            
        newTrans := Max(currentTrans - 5, 50) ; Don't go below 50 or it's invisible
        WinSetTransparent(newTrans, "A")
        ToolTip("Opacity: " . Round((newTrans / 255) * 100) . "%")
        SetTimer () => ToolTip(), -1000 ; Hide after 1 second
    }
}

; Alt + Shift + Z dim screen
!<+z::
{
    static DimGui := 0
    if !DimGui {
        vLeft := SysGet(76) 
        vTop := SysGet(77)    
        vWidth := SysGet(78)  
        vHeight := SysGet(79) 

        DimGui := Gui("-Caption +AlwaysOnTop +E0x20 +ToolWindow") 
        DimGui.BackColor := "000000"
        
        DimGui.Show("x" vLeft " y" vTop " w" vWidth " h" vHeight)
        
        WinSetTransparent(150, DimGui)
    } else {
        DimGui.Destroy()
        DimGui := 0
    }
}

SetCapsLockState "AlwaysOff"

#HotIf GetKeyState("CapsLock", "P")

; Movement (HJKL)
h::MouseMove(-20, 0, 0, "R")
Left::MouseMove(-20, 0, 0, "R")
j::MouseMove(0, 20, 0, "R")
Down::MouseMove(0, 20, 0, "R")
k::MouseMove(0, -20, 0, "R")
Up::MouseMove(0, -20, 0, "R")
l::MouseMove(20, 0, 0, "R")
Right::MouseMove(20, 0, 0, "R")

; Precision Movement (Shift + HJKL for slow movement)
+h::MouseMove(-5, 0, 0, "R")
+Left::MouseMove(-5, 0, 0, "R")
+j::MouseMove(0, 5, 0, "R")
+Down::MouseMove(0, 5, 0, "R")
+k::MouseMove(0, -5, 0, "R")
+Up::MouseMove(0, -5, 0, "R")
+l::MouseMove(5, 0, 0, "R")
+Right::MouseMove(5, 0, 0, "R")

; Mouse Clicks
f::Click "Left"         ; F for "Fire" (Left Click)
d::Click "Right"        ; D for "Data" (Right Click)
s::Click "Middle"       ; S for "Scroll/Middle"

; Scrolling (U and I)
u::Click "WheelUp"
`;::Click "WheelUp"
i::Click "WheelDown"
'::Click "WheelDown"

#HotIf

+CapsLock:: {
    state := GetKeyState("CapsLock", "T")
    if state
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "AlwaysOn"
}