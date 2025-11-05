--[[
    Default Display Mode for Weather Lockscreen
    Shows detailed weather with hourly forecasts
--]]

local ImageWidget = require("ui/widget/imagewidget")
local TextWidget = require("ui/widget/textwidget")
local VerticalGroup = require("ui/widget/verticalgroup")
local HorizontalGroup = require("ui/widget/horizontalgroup")
local HorizontalSpan = require("ui/widget/horizontalspan")
local VerticalSpan = require("ui/widget/verticalspan")
local CenterContainer = require("ui/widget/container/centercontainer")
local OverlapGroup = require("ui/widget/overlapgroup")
local Font = require("ui/font")
local Device = require("device")
local Screen = Device.screen
local Blitbuffer = require("ffi/blitbuffer")

local WEATHER_ICON_SIZE = 200

local DefaultDisplay = {}

function DefaultDisplay:create(weather_lockscreen, weather_data)
    -- Calculate scale factor
    local screen_width = Screen:getWidth()
    local base_width = 600
    local scale_factor = math.min(2.5, math.max(1.0, screen_width / base_width))
    
    local current_icon_size = math.floor(WEATHER_ICON_SIZE * scale_factor)
    local hourly_icon_size = math.floor(WEATHER_ICON_SIZE * 0.4 * scale_factor)
    local temp_font_size = math.floor(32 * scale_factor)
    local condition_font_size = math.floor(24 * scale_factor)
    local label_font_size = math.floor(20 * scale_factor)
    local hour_font_size = math.floor(16 * scale_factor)
    local header_font_size = math.floor(16 * scale_factor)
    local vertical_spacing = math.floor(20 * scale_factor)
    local horizontal_spacing = math.floor(15 * scale_factor)
    local header_margin = math.floor(10 * scale_factor)
    
    local widgets = {}
    
    -- Header: Location and Timestamp
    local header_group = weather_lockscreen:createHeaderWidgets(header_font_size, header_margin, weather_data, Blitbuffer.COLOR_DARK_GRAY, weather_data.is_cached)
    
    -- Current weather
    local current_widgets = {}
    
    local icon_widget = ImageWidget:new{
        file = weather_data.current.icon_path,
        width = current_icon_size,
        height = current_icon_size,
        alpha = true,
    }
    table.insert(current_widgets, icon_widget)
    
    if weather_data.current.temperature then
        table.insert(current_widgets, TextWidget:new{
            text = weather_data.current.temperature,
            face = Font:getFace("cfont", temp_font_size),
            bold = true,
        })
    end
    
    if weather_data.current.condition then
        table.insert(current_widgets, TextWidget:new{
            text = weather_data.current.condition,
            face = Font:getFace("cfont", condition_font_size),
        })
    end
    
    table.insert(widgets, VerticalGroup:new{
        align = "center",
        unpack(current_widgets)
    })
    
    table.insert(widgets, VerticalSpan:new{ height = vertical_spacing })
    
    -- Today's hourly forecast
    if weather_data.hourly_today and #weather_data.hourly_today > 0 then
        table.insert(widgets, TextWidget:new{
            text = "Today",
            face = Font:getFace("cfont", label_font_size),
            bold = true,
        })
        
        local today_row = {}
        for i, hour_data in ipairs(weather_data.hourly_today) do
            if i > 1 then
                table.insert(today_row, HorizontalSpan:new{ width = horizontal_spacing })
            end
            
            local hour_widgets = {}
            table.insert(hour_widgets, TextWidget:new{
                text = hour_data.hour,
                face = Font:getFace("cfont", hour_font_size),
            })
            
            if hour_data.icon_path then
                table.insert(hour_widgets, ImageWidget:new{
                    file = hour_data.icon_path,
                    width = hourly_icon_size,
                    height = hourly_icon_size,
                    alpha = true,
                })
            end
            
            table.insert(hour_widgets, TextWidget:new{
                text = hour_data.temperature,
                face = Font:getFace("cfont", hour_font_size),
            })
            
            table.insert(today_row, VerticalGroup:new{
                align = "center",
                unpack(hour_widgets)
            })
        end
        
        table.insert(widgets, HorizontalGroup:new{
            align = "center",
            unpack(today_row)
        })
        
        table.insert(widgets, VerticalSpan:new{ height = vertical_spacing })
    end
    
    -- Tomorrow's hourly forecast
    if weather_data.hourly_tomorrow and #weather_data.hourly_tomorrow > 0 then
        table.insert(widgets, TextWidget:new{
            text = "Tomorrow",
            face = Font:getFace("cfont", label_font_size),
            bold = true,
        })
        
        local tomorrow_row = {}
        for i, hour_data in ipairs(weather_data.hourly_tomorrow) do
            if i > 1 then
                table.insert(tomorrow_row, HorizontalSpan:new{ width = horizontal_spacing })
            end
            
            local hour_widgets = {}
            table.insert(hour_widgets, TextWidget:new{
                text = hour_data.hour,
                face = Font:getFace("cfont", hour_font_size),
            })
            
            if hour_data.icon_path then
                table.insert(hour_widgets, ImageWidget:new{
                    file = hour_data.icon_path,
                    width = hourly_icon_size,
                    height = hourly_icon_size,
                    alpha = true,
                })
            end
            
            table.insert(hour_widgets, TextWidget:new{
                text = hour_data.temperature,
                face = Font:getFace("cfont", hour_font_size),
            })
            
            table.insert(tomorrow_row, VerticalGroup:new{
                align = "center",
                unpack(hour_widgets)
            })
        end
        
        table.insert(widgets, HorizontalGroup:new{
            align = "center",
            unpack(tomorrow_row)
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

return DefaultDisplay
