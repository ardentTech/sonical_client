module Units exposing (..)


-- @todo manage space prefix here instead of within appendUnit


centimeters : String
centimeters = " cm"

centimeters_squared : String
centimeters_squared = centimeters ++ squared

cubed : String
cubed = "^3"

decibels : String
decibels = " dB"

feet : String
feet = " ft"

feet_cubed : String
feet_cubed = feet ++ cubed

grams : String
grams = "g"

hertz : String
hertz = "  Hz"

inches : String
inches = "\""

millimeters : String
millimeters = "mm"

millimeters_newton : String
millimeters_newton = "mm/N"

millihenries : String
millihenries = " mH"

ohms : String
ohms = " Ω"

squared : String
squared = "^2"

tesla_meters : String
tesla_meters = "Tm"

watts : String
watts = " W"
