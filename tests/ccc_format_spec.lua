-- Environment mocking utility
local captured_input

-- Mock dependencies
package.preload["ccc.input"] = function() return {} end
package.preload["ccc.utils.convert"] = function() return {} end
package.preload["ccc"] = function()
    return {
        setup = function(opts)
            captured_input = opts.inputs[1]
        end
    }
end

-- Mock vim globals
_G.vim = {
    inspect = function(t) return tostring(t) end,
    trim = function(s) return s:match("^%s*(.-)%s*$") end,
}

-- Add lua to path
package.path = package.path .. ";lua/?.lua;lua/?/init.lua"

-- Require the actual module to capture RgbHslCmykInput
require("custom.ccc")

local RgbHslCmykInput = captured_input
if not RgbHslCmykInput then
    print("FAILED: Failed to capture RgbHslCmykInput from lua/custom/ccc.lua")
    os.exit(1)
end

-- Simple test runner
local function assert_eq(actual, expected, message)
    if actual ~= expected then
        print("FAILED: " .. message)
        print("  Expected: [" .. tostring(expected) .. "]")
        print("  Actual:   [" .. tostring(actual) .. "]")
        os.exit(1)
    else
        print("PASSED: " .. message)
    end
end

print("Running tests for RgbHslCmykInput.format from lua/custom/ccc.lua...")

-- Test RGB (i <= 3)
assert_eq(RgbHslCmykInput.format(1, 1), "   255", "RGB max (i=1)")
assert_eq(RgbHslCmykInput.format(0, 2), "     0", "RGB min (i=2)")
assert_eq(RgbHslCmykInput.format(0.5, 3), "   127", "RGB mid (i=3)")

-- Test HSL S/L (i == 5 or i == 6)
assert_eq(RgbHslCmykInput.format(1, 5), "   100", "HSL S max (i=5)")
assert_eq(RgbHslCmykInput.format(0.5, 6), "    50", "HSL L mid (i=6)")

-- Test CMYK (i >= 7)
assert_eq(RgbHslCmykInput.format(1, 7), "100.0%", "CMYK C max (i=7)")
assert_eq(RgbHslCmykInput.format(0, 8), "  0.0%", "CMYK M min (i=8)")
assert_eq(RgbHslCmykInput.format(0.5, 9), " 50.0%", "CMYK Y mid (i=9)")
assert_eq(RgbHslCmykInput.format(0.1234, 10), " 12.0%", "CMYK K precision (i=10)")
assert_eq(RgbHslCmykInput.format(0.127, 10), " 12.5%", "CMYK K precision 0.5 step (i=10)")
assert_eq(RgbHslCmykInput.format(0.999, 7), " 99.5%", "CMYK C near 100% (i=7)")

-- Test others (like H, i=4)
assert_eq(RgbHslCmykInput.format(180, 4), "   180", "HSL H (i=4)")

print("All tests passed!")
