module Commands exposing (getDrivers, queryDrivers)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (Model)
import Rest exposing (getList)


-- @todo convert manufacturer name to id
-- @todo validate input?


type alias QueryParam = { key : String, value : String }


getDrivers : Model -> Maybe String -> Cmd Msg
getDrivers model url =
  let
    endpoint =
      case url of
        Nothing -> driversUrl model
        Just s -> s
    queryParams = ""
  in
    getList (endpoint ++ queryParams) driversDecoder GetDriversDone


queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    endpoint = driversUrl model
  in
    getList (endpoint ++ model.queryBuilderVal) driversDecoder GetDriversDone
