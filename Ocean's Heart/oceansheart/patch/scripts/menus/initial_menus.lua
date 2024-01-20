--[[initial_menus.lua
	version 1.0.1
	29 Aug 2020
	GNU General Public License Version 3
	author: Llamazing

	   __   __   __   __  _____   _____________  _______
	  / /  / /  /  | /  |/  /  | /__   /_  _/  |/ / ___/
	 / /__/ /__/ ^ |/ , ,  / ^ | ,:',:'_/ // /|  / /, /
	/____/____/_/|_/_/|/|_/_/|_|_____/____/_/ |_/____/

	This script manages the initial menus shown when launching the quest. Any active menus
	are closed when a game is started, and the last initial menu should ensure that a game
	is started before it is closed.

	The initial menus are skipped when sol.main.reset() is called, where the starting menu
	index is specified by the key first_index_on_reset of the MENU_LIST table (the default
	is the last menu if omitted). Negative values are allowed, counting backwards from the
	end.

	Usage:
	local initial_menus = require"scripts/menus/initial_menu"
	initial_menus.start(context, on_top)
--]]

local multi_events = require"scripts/multi_events"

--menus to show when starting game in this order
--NOTE: the last menu is responsible for starting the game
local MENU_LIST = {
  "scripts/menus/maxmraz_splash",
  "scripts/menus/nordcurrent_splash",
  "scripts/menus/solarus_logo",
  "scripts/menus/language",
  "scripts/menus/title_screen_menus/top_menu",
  music = "title_screen_piano_only",
  first_index_on_reset = nil, --uses last index if not specified
}


if sol.file.exists"debug.lua" then
  print"Debug.lua present"
  sol.language.set_language(sol.language.get_language() or "en")
  sol.main.debug_mode = true
  MENU_LIST = {
    "scripts/menus/title_screen_menus/top_menu",
    music = "title_screen_piano_only",
    first_index_on_reset = nil, --uses last index if not specified
  }
end

local initial_menus = {}

local menus = {} --(table, array) list of initial menus
local active_context --(various or nil) context to use for newly started initial menus
local active_menu --(table, key/vale or nil) menu currently active or nil if none
local active_on_top --(boolean or nil) whether newly started initial menus should be drawn on top of other menus

--close any active initial menu when game starts
local game_meta = sol.main.get_metatable"game"
game_meta:register_event("on_started", function(self) initial_menus.stop() end)

--// clear the variables related to the active menu
local function reset()
	active_menu = nil
	active_context = nil
	active_on_top = nil
end

--Initialize
for i,menu_script in ipairs(MENU_LIST) do
	--load initial menu scripts
	local menu = require(menu_script)
	table.insert(menus, menu)

	--register menu with multi-events if not already
	if not menu.register_event then multi_events:enable(menu) end

	--start next menu whenever a menu is closed
menu:register_event("on_finished", function(self)
    local next_menu = menus[i+1]
    
    if active_menu and next_menu and not sol.menu.is_started(next_menu) then
        active_menu = next_menu

        -- Ensure on_top is a boolean, default to true if nil
        local is_success, err = pcall(function()
            if on_top == nil then
                on_top = true
            end
            sol.menu.start(active_context, next_menu, on_top)
        end)

        if not is_success then
            reset()
            error(err)
        end
    else
        reset()
    end
end)
end
if #menus>0 then
	menus[#menus]:register_event("on_started", function(self) reset() end) --cease sequence when final menu is started
end

--// Starts the first initial menu, can only be called if no initial menu is currently running
	--context (various, optional) - context to use when starting the menu, see sol.menu.start() documentation
		--default: sol.main
	--on_top (boolean, optional) - whether the menu should be drawn on top of other menus
		--default: false (drawn on bottom)
function initial_menus.start(context, on_top)
	assert(not active_menu, "Error in 'initial_menus': already started")
	if #menus==0 then return end --do nothing if no initial menus defined
	context = context or sol.main
	on_top = on_top or false

	--only show splash screens when launching the quest, not when quitting to main menu via sol.main.reset()
	local start_index = 1 --tentative
	if sol.main.get_elapsed_time() > 5000 then
		start_index = MENU_LIST.first_index_on_reset or #MENU_LIST
		if start_index < 1 then start_index = start_index + #MENU_LIST + 1 end --count backwards
	end

	local first_menu = menus[start_index]
	if not first_menu or sol.menu.is_started(first_menu) then return end --bogus index specified by first_index_on_reset

	active_context = context
	active_menu = first_menu
	active_on_top = on_top

	--start the first initial menu, sets active_menu to nil if there is an error in starting the menu
	local is_success, err = pcall(function() sol.menu.start(context, first_menu, on_top) end)
	if not is_success then
		reset()
		error(err)
	end

	if MENU_LIST.music then sol.audio.play_music(MENU_LIST.music) end
end

--// Stops the active initial menu if one is currently active, otherwise does nothing
function initial_menus.stop()
	if active_menu then
		local menu_to_stop = active_menu --save reference before reset
		reset() --reset before stopping active menu so next menu won't be started
		sol.menu.stop(menu_to_stop)
	end
end

--// Returns the active initial menu (table, key/value) or nil if not running
function initial_menus.active_menu() return active_menu end

--// Starts the next initial menu if currently running, otherwise does nothing
function initial_menus.next()
	if active_menu then	sol.menu.stop(active_menu) end
end

return initial_menus

--[[ Copyright 2019-2020 Llamazing
  []
  [] This program is free software: you can redistribute it and/or modify it under the
  [] terms of the GNU General Public License as published by the Free Software Foundation,
  [] either version 3 of the License, or (at your option) any later version.
  []
  [] It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
  [] without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  [] PURPOSE.  See the GNU General Public License for more details.
  []
  [] You should have received a copy of the GNU General Public License along with this
  [] program.  If not, see <http://www.gnu.org/licenses/>.
  ]]
