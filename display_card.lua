--[[
    Card Display Mode for Weather Lockscreen
    Clean minimal card-style display
--]]

local ImageWidget = require("ui/widget/imagewidget")
local TextWidget = require("ui/widget/textwidget")
local VerticalGroup = require("ui/widget/verticalgroup")
local VerticalSpan = require("ui/widget/verticalspan")
local CenterContainer = require("ui/widget/container/centercontainer")
local OverlapGroup = require("ui/widget/overlapgroup")
local Font = require("ui/font")
local Device = require("device")
local Screen = Device.screen
local Blitbuffer = require("ffi/blitbuffer")

local CardDisplay = {}

function CardDisplay:create(weather_lockscreen, weather_data)
    local screen_width = Screen:getWidth()
    local base_width = 600
    local scale_factor = math.min(2.5, math.max(1.0, screen_width / base_width))
    
    -- Typography
    local header_font_size = math.floor(16 * scale_factor)
    local temp_font_size = math.floor(52 * scale_factor)
    local condition_font_size = math.floor(22 * scale_factor)
    local detail_font_size = math.floor(18 * scale_factor)
    local icon_size = math.floor(180 * scale_factor)
    local spacing = math.floor(20 * scale_factor)
    local header_margin = math.floor(10 * scale_factor)
    
    -- Header: Location and Timestamp
    local header_group = weather_lockscreen:createHeaderWidgets(header_font_size, header_margin, weather_data, Blitbuffer.COLOR_DARK_GRAY, weather_data.is_cached)
    
    -- Main content
    local widgets = {}
    
    -- Weather icon
    if weather_data.current.icon_path then
        table.insert(widgets, ImageWidget:new{
            file = weather_data.current.icon_path,
            width = icon_size,
            height = icon_size,
            alpha = true,
        })
        table.insert(widgets, VerticalSpan:new{ width = spacing })
    end
    
    -- Temperature
    if weather_data.current.temperature then
        table.insert(widgets, TextWidget:new{
            text = weather_data.current.temperature,
            face = Font:getFace("cfont", temp_font_size),
            bold = true,
        })
        table.insert(widgets, VerticalSpan:new{ width = math.floor(spacing * 0.3) })
    end
    
    -- Condition
    if weather_data.current.condition then
        table.insert(widgets, TextWidget:new{
            text = weather_data.current.condition,
            face = Font:getFace("cfont", condition_font_size),
        })
        table.insert(widgets, VerticalSpan:new{ width = spacing })
    end
    
    -- High/Low if available
    if weather_data.forecast_days and weather_data.forecast_days[1] and weather_data.forecast_days[1].high_low then
        table.insert(widgets, TextWidget:new{
            text = weather_data.forecast_days[1].high_low,
            face = Font:getFace("cfont", detail_font_size),
            fgcolor = Blitbuffer.COLOR_DARK_GRAY,
        })
    end
    
    local weather_group = VerticalGroup:new{
        align = "center",
        unpack(widgets)
    }
    
    local main_content = CenterContainer:new{
        dimen = Screen:getSize(),
        weather_group,
    }
    
    return OverlapGroup:new{
        dimen = Screen:getSize(),
        main_content,
        header_group,
    }
end

return CardDisplay
