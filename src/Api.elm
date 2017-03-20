module Api exposing (..)

import Models exposing (Model)


driversUrl : Model -> String
driversUrl model = model.apiUrl ++ "/drivers/"


manufacturersUrl : Model -> String
manufacturersUrl model = model.apiUrl ++ "/manufacturers/"
