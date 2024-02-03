-- Script that creates a game ready to be played.

local game_manager = {}

require("scripts/multi_events")

--------------------------------------------------------------------------------------------
-- Sets initial values for a new savegame of this quest.-----------------------------------

local function initialize_new_savegame(game)

  game:set_starting_location("intro")

  -- game:set_ability("lift", 0) -- this ability is not avaiable
  -- game:set_ability("sword", 1) -- this ability is not avaiable
  game:set_max_life(6)
  game:set_life(game:get_max_life())
  game:set_max_money(999)
  game:get_item("inventory/uniform"):set_variant(1)
  local cart = game:get_item("inventory/rifle_cart")
  cart:set_variant(1)

  game:set_value("amount_gremlins", 0)
  game:set_value("amount_karma", 0)
  game:set_value("time_played", 0)
  game:set_value("keyboard_save", "escape")
  game:set_value("keyboard_run", "left shift")

end

--------------------------------------------------------------------------------------------
-- Measures the time played in this savegame.

local function run_chronometer(game)

  local timer = sol.timer.start(game, 100, function()

    local time = game:get_value("time_played")
    time = time + 100
    game:set_value("time_played", time)
    return true  -- Repeat the timer.

  end)
  timer:set_suspended_with_map(false)

end

--------------------------------------------------------------------------------------------
-- Changes the walking speed of the hero

local function update_walking_speed(game)

  local normal_walking_speed = 122
  local fast_walking_speed = 244

  local hero = game:get_hero()
  local speed = normal_walking_speed
  local modifiers = sol.input.get_key_modifiers()
  local keyboard_run_pressed = sol.input.is_key_pressed(game:get_value("keyboard_run")) or modifiers["caps lock"]
  local joypad_run_pressed = false
  local joypad_action = game:get_value("joypad_run")
  if joypad_action ~= nil then
    local button = joypad_action:match("^button (%d+)$")
    if button ~= nil then
  	joypad_run_pressed = sol.input.is_joypad_button_pressed(button)
    end
  end
  if game:get_value("possession_black_cat_pants") then
    if keyboard_run_pressed or joypad_run_pressed then
      speed = fast_walking_speed
    end
  end

  if hero:get_walking_speed() ~= speed then
    hero:set_walking_speed(speed)
  end

end

-- Creates a game ready to be played.  --------------------------------------------------------

function game_manager:create(file_name)

  local exists = sol.game.exists(file_name)
  local game = sol.game.load(file_name)
  if not exists then
    -- Initialize a new savegame.
    initialize_new_savegame(game)
  end


  -- Function called when the player runs this game.
  game:register_event("on_started", function(game)

    update_walking_speed(game)
    run_chronometer(game)

  end)

  -- Function called when the player presses a key during the game.
  game:register_event("on_key_pressed", function(game, key)

    if game.customizing_command then
      -- Don't treat this input normally, it will be recorded as a new command binding
      -- by the commands menu.
      return false
    end

    local handled = false

    if game:is_pause_allowed() then  -- Keys below are menus.

      if key == game:get_value("keyboard_run") or key == "caps lock" then

        update_walking_speed(game)
        handled = true

      elseif key == game:get_value("keyboard_save") then

        if not game:is_paused() and not game:is_dialog_enabled() and game:get_life() > 0 then

          game:start_dialog("save_quit", function(answer)

            if answer == 1 then
              -- Continue.
              sol.audio.play_sound("osana/choice2")
            elseif answer == 2 then
              -- Save and quit.
              sol.audio.play_sound("osana/choice2")
              game:save()
              sol.main.reset()
            else
              -- Quit without saving.
              sol.audio.play_sound("osana/choice2")
              sol.main.reset()
            end
          end)

          handled = true

        end

      end

    end

    return handled
  end)



  -- Function called when the player releases a key during the game.
  game:register_event("on_key_released", function(game, key)

    local handled = false
    if key == game:get_value("keyboard_run") or key == "caps lock" then

      update_walking_speed(game)
      handled = true

    end

    return handled
  end)

  -- Returns the game time in seconds.
  function game:get_time_played()

    local milliseconds = game:get_value("time_played")
    local total_seconds = math.floor(milliseconds / 1000)
    return total_seconds

  end

  -- Returns a string representation of the game time.
  function game:get_time_played_string()

    local total_seconds = game:get_time_played()
    local seconds = total_seconds % 60
    local total_minutes = math.floor(total_seconds / 60)
    local minutes = total_minutes % 60
    local total_hours = math.floor(total_minutes / 60)
    local time_string = string.format("%02d:%02d:%02d", total_hours, minutes, seconds)
    return time_string

  end

  return game
end


-- TODO the engine should have an event game:on_world_changed().
local game_meta = sol.main.get_metatable("game")
game_meta:register_event("on_map_changed", function(game)

  local map = game:get_map()
  local new_world = map:get_world()
  local previous_world = game.previous_world
  local world_changed = previous_world == nil or
      new_world == nil or
      new_world ~= previous_world
  game.previous_world = new_world
  if world_changed then
    if game.notify_world_changed ~= nil then
      game:notify_world_changed(previous_world, new_world)
    end
  end
end)

game_meta:register_event("on_game_over_started", function(game)
  -- Reset the previous world info on game-over
  -- so that notify_world_changed gets called.
  game.previous_world = nil
end)

return game_manager
