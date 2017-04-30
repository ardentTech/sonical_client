module Commands exposing (
  getDrivers, getDriversNextPage, getDriversPreviousPage, queryDrivers)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (Model)
import Rest exposing (getList)


type alias QueryParam = { key : String, value : String }


getDrivers : Model -> Cmd Msg
getDrivers model =
  getList (driversUrl model) driversDecoder GetDriversDone


getDriversNextPage : Model -> Cmd Msg
getDriversNextPage model =
  getDriversPage model.driversNextPage


getDriversPreviousPage : Model -> Cmd Msg
getDriversPreviousPage model =
  getDriversPage model.driversPreviousPage


-- @todo convert manufacturer name to id
-- @todo validate input?
queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    endpoint = driversUrl model
  in
    getList (endpoint ++ model.driversQuery) driversDecoder GetDriversDone


-- PRIVATE


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> getList str driversDecoder GetDriversDone
