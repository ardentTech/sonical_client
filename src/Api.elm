module Api exposing (..)

import Models exposing (Model)


driverUrl : Model -> Int -> String
driverUrl model i = (driversUrl model) ++ (toString i) ++ "/"


driversUrl : Model -> String
driversUrl model = model.apiUrl ++ "/drivers/"
