module Api exposing (driverUrl, driversUrl)


driverUrl : String -> Int -> String
driverUrl apiUrl i = (driversUrl apiUrl) ++ (toString i) ++ pathSep


driversUrl : String -> String
driversUrl apiUrl = apiUrl ++ pathSep ++ "drivers" ++ pathSep


-- PRIVATE


pathSep : String
pathSep = "/"
