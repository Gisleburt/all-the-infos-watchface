local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

function outExpo (time, start, finish, duration)
    if time >= duration then
        return finish
    end
    change = finish - start
    return change * 1.001 * (-pow(2, -10 * time / duration) + 1) + start
end

function inOutExpo(time, start, finish, duration)
    change = finish - start
    if time <= 0 then return start end
    if time >= duration then return finish end
    time = time / duration * 2
    if time < 1 then
        return change / 2 * pow(2, 10 * (time - 1)) - finish
    end
    time = time - 1
    return change / 2 * 1.0005 * (-pow(2, -10 * time) + 2) + start
end

var_ms_heartbeat = 0.0
var_ms_total_time = 0.0
var_ms_reverse = false
var_ms_half_beat = (60.0 / {shr}) / 2
var_ms_min = 50
var_ms_max = 100
var_ms_dt = 0.0

function on_millisecond(dt)
    var_ms_dt = dt
    var_ms_total_time = var_ms_total_time + dt
    if var_ms_reverse then
        var_ms_heartbeat = inOutExpo(var_ms_half_beat, var_ms_max, var_ms_min, var_ms_total_time)
        if var_ms_total_time >= var_ms_half_beat then
            var_ms_half_beat = (60.0 / {shr}) / 2
            var_ms_total_time = 0.0
            var_ms_reverse = false
        end
        return
    end
    var_ms_heartbeat = outExpo(var_ms_half_beat, var_ms_min, var_ms_max, var_ms_total_time)
    if var_ms_total_time >= var_ms_half_beat then
        var_ms_half_beat = (60.0 / {shr}) / 2
        var_ms_total_time = 0.0
        var_ms_reverse = true
    end
end