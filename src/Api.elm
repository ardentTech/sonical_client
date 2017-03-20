module Api exposing (driversUrl)

import Models exposing (Model)


driversUrl : Model -> String
driversUrl model = model.apiUrl ++ "/drivers/"
