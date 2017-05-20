module Api exposing (driverUrl, driversUrl, manufacturersUrl)


driverUrl : String -> Int -> String
driverUrl apiUrl i = (driversUrl apiUrl) ++ (toString i) ++ pathSep


driversUrl : String -> String
driversUrl apiUrl = apiUrl ++ pathSep ++ "drivers" ++ pathSep


manufacturersUrl : String -> String
manufacturersUrl apiUrl = apiUrl ++ pathSep ++ "manufacturers" ++ pathSep


-- PRIVATE


pathSep : String
pathSep = "/"
