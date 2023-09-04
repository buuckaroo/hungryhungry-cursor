--[[
This uses the LuaRT Framework; https://www.luart.org.
Audio module does not work at this moment.
THIS COMPILER IS A NIGHTMARE!!!
--]]

--win.lua
local ui = require('ui')
--local audio = require('audio')
--local data = require('src.data')

local data = {}

--win data
data.cookies = 0     -- current amount of cookies
data.multiplier = 1  -- cookie multipler (used for multipling the c_per_click)
data.c_per_click = 1 -- cookie per click (the amount of cookies you'll get when you click the cookie image

local cookie_debounce = false
local click_delay = false

local c_per_click_price = 15
local multiplier_price = 100

--local sfx = {
--  ['click'] = audio.Sound('assets\\audios\\click.wav'),
--  ['purchased'] = audio.Sound('assets\\audios\\purchased.wav'),
--  ['error'] = audio.Sound('assets\\audios\\error.wav')
--}
local label_config = {
  ['font'] = 'Times new roman',
  ['fontsize'] = 12,
}

--user interface
local win = ui.Window('Hungry-Hungry Cursor', 'fixed', 500, 500)
--|
--v
local cookie_image            = ui.Picture(win, 'assets\\textures\\cookie.png', 170, 110); cookie_image.cursor = 'hand'
local cookie_dis              = ui.Label(win, string.format('Cookies: %s', data.cookies), 200, 0); cookie_dis.font = label_config.font; cookie_dis.fontsize = label_config.fontsize
local cookie_multiplier_dis   = ui.Label(win, string.format('Multiplier: %s', data.multiplier), 198, 20); cookie_multiplier_dis.font = label_config.font; cookie_multiplier_dis.fontsize = label_config.fontsize
local cookie_per_click_dis    = ui.Label(win, string.format('Cookies-per Click: %s', data.c_per_click), 170, 40); cookie_per_click_dis.font = label_config.font; cookie_per_click_dis.fontsize = label_config.fontsize
--|
--V
cookie_image.onClick = function(self)
  if not cookie_debounce then
    cookie_debounce = true
    
    --animation start
    cookie_image.x = cookie_image.x - 2
    cookie_image.width = cookie_image.width + 5
    
    cookie_image.y = cookie_image.y - 2
    cookie_image.height = cookie_image.height + 5
    
    sleep(31)
    
    --animation end
    cookie_image.x = cookie_image.x + 2
    cookie_image.width = cookie_image.width - 5
    
    cookie_image.y = cookie_image.y + 2
    cookie_image.height = cookie_image.height - 5
    
    --logic
    data.cookies = data.cookies + (data.c_per_click * data.multiplier)
    cookie_dis.text = string.format('Cookies: %s', data.cookies)
    --sfx.click:play()
    
    cookie_debounce = false
  end
end

local shop_label         = ui.Label(win, '--- SHOP ---', 195, 300); shop_label.font = label_config.font; shop_label.fontsize = label_config.fontsize
local c_per_click_button = ui.Button(win, string.format('Cookies: %s | 1+ Cookies-per Click', c_per_click_price), 120, 320); c_per_click_button.font = label_config.font; c_per_click_button.fontsize = label_config.fontsize
local multiplier_button  = ui.Button(win, string.format('Cookies: %s | 1+ Multiplier', multiplier_price), 145, 350); multiplier_button.font = label_config.font; multiplier_button.fontsize = label_config.fontsize
--|
--V
c_per_click_button.onClick = function(self)
  if data.cookies >= c_per_click_price then
    --logic
    data.cookies = data.cookies - c_per_click_price
    data.c_per_click = data.c_per_click + 1
    cookie_dis.text = string.format('Cookies: %s', data.cookies)
    cookie_per_click_dis.text = string.format('Cookies-per Click: %s', data.c_per_click)
    --sfx.purchased:play()
  else
    --sfx.error:play()
  end
end
--|
--V
multiplier_button.onClick = function(self)
  if data.cookies >= multiplier_price then
    --logic
    data.cookies = data.cookies - multiplier_price
    data.multiplier = data.multiplier + 1
    cookie_dis.text = string.format('Cookies: %s', data.cookies)
    cookie_multiplier_dis.text = string.format('Multiplier: %s', data.multiplier)
    --sfx.purchased:play()
  else
    --sfx.error:play()
  end
end

local about_label = ui.Label(win, '--- ABOUT ---', 190, 400); about_label.font = label_config.font; about_label.fontsize = label_config.fontsize
local info_label  = ui.Label(win, 'Opensource project for me to help educate myself on LuaRT.', 50, 420); info_label.font = label_config.font; info_label.fontsize = 12

--update loop
win:show()
repeat
  ui.update()
until not win.visible