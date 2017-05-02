module Commands exposing (
  getDrivers, getDriversNextPage, getDriversPreviousPage, queryDrivers)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (Model)
import Rest exposing (getList)


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
-- @todo don't fire requests on empty submit
queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    query =
      case String.startsWith "?" model.driversQuery of
        True -> model.driversQuery
        False -> "?" ++ model.driversQuery
  in
    getList ((driversUrl model) ++ query) driversDecoder GetDriversDone


-- PRIVATE


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> getList str driversDecoder GetDriversDone
