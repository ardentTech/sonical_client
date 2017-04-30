module Commands exposing (..)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (Model)
import Rest exposing (getList)


-- @todo convert manufacturer name to id
-- @todo validate input?


type alias QueryParam = { key : String, value : String }


getDrivers : Model -> Cmd Msg
getDrivers model =
  getList (driversUrl model) driversDecoder GetDriversDone


getDriversNextPage : Model -> Cmd Msg
getDriversNextPage model =
  getDriversPage model.driversNextPage


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> getList str driversDecoder GetDriversDone


getDriversPreviousPage : Model -> Cmd Msg
getDriversPreviousPage model =
  getDriversPage model.driversPreviousPage


queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    endpoint = driversUrl model
  in
    getList (endpoint ++ model.queryBuilderVal) driversDecoder GetDriversDone
