module Drivers.Commands exposing (
  getDriver,
  getDrivers,
  getDriversNextPage,
  getDriversPreviousPage,
  getDriversWithParams,
  queryDrivers)

import Api exposing (driverUrl, driversUrl)
import Drivers.Decoders exposing (driverDecoder, driversDecoder)
import Drivers.QueryParams exposing (unpack)
import Drivers.Messages exposing (Msg (GetDriverDone, GetDriversDone))
import Models exposing (Model)
import Rest exposing (getItem, getList)


-- @todo explicit next/previous page commands seems a bit much...


getDriver : Model -> Int -> Cmd Msg
getDriver model i =
  let
    url = driverUrl model.apiUrl i
  in
    getItem url driverDecoder GetDriverDone


getDrivers : Model -> Cmd Msg
getDrivers model =
  getDriversPage (Just (driversUrl model.apiUrl))


getDriversWithParams : Model -> String -> Cmd Msg
getDriversWithParams model params =
  getDriversPage (Just <| (driversUrl model.apiUrl) ++ (unpack params))


getDriversNextPage : Model -> Cmd Msg
getDriversNextPage model =
  getDriversPage model.driversNextPage


getDriversPreviousPage : Model -> Cmd Msg
getDriversPreviousPage model =
  getDriversPage model.driversPreviousPage


-- @todo convert manufacturer name to id
-- @todo validate input
queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    query =
      case String.startsWith "?" model.driversQuery of
        True -> model.driversQuery
        False -> "?" ++ model.driversQuery
  in
    getList ((driversUrl model.apiUrl) ++ query) driversDecoder GetDriversDone


-- PRIVATE


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> getList str driversDecoder GetDriversDone
