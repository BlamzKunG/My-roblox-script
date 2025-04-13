local Origin = loadstring(game:HttpGet("https://raw.githubusercontent.com/OriginHub/OriginUILibrary/main/Library.lua"))()

local Window = Origin:CreateWindow({
    Name = "My Origin UI", -- ชื่อ UI
    LoadingTitle = "Loading...", -- ชื่อเวลารัน
    LoadingSubtitle = "Please wait", -- ข้อความใต้ชื่อ
    ConfigurationSaving = {
        Enabled = false, -- ปิดระบบ save config ไว้ก่อน
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false, -- ปิดระบบใส่ Key
})

-- สร้างแท็บ
local Tab = Window:CreateTab("Main", 4483362458) -- ชื่อ Tab + รูป icon จาก id

-- สร้าง Section
local Section = Tab:CreateSection("Main Functions")

-- สร้างปุ่ม
Section:AddButton({
    Name = "Click me",
    Callback = function()
        print("You clicked the button!")
    end,
})

-- สร้าง Toggle
Section:AddToggle({
    Name = "Enable Something",
    Default = false,
    Callback = function(Value)
        print("Toggle is now:", Value)
    end,
})
