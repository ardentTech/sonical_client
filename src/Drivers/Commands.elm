module Drivers.Commands exposing (
  getDriver,
  getDrivers,
  getDriversWithParams,
  queryDrivers)

import Api exposing (driverUrl, driversUrl)
import Drivers.Decoders exposing (driverDecoder, driversDecoder)
import Drivers.Messages exposing (..)
import Models exposing (Model)
import QueryParams exposing (formatForUrl)
import Rest exposing (getItem, getList)


getDriver : Model -> Int -> Cmd Msg
getDriver model i =
  let
    url = driverUrl model.apiUrl i
  in
    Cmd.map ForSelf <| getItem url driverDecoder GetDriverDone


getDrivers : Model -> Cmd Msg
getDrivers model =
  getDriversPage (Just <| (driversUrl model.apiUrl) ++ (formatForUrl model.queryParams))


getDriversWithParams : Model -> String -> Cmd Msg
getDriversWithParams model params =
  getDriversPage (Just <| driversUrl model.apiUrl)
--  getDriversPage (Just <| (driversUrl model.apiUrl) ++ (unpack params))


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
    Cmd.map ForSelf <| getList (
      (driversUrl model.apiUrl) ++ query) driversDecoder GetDriversDone


-- PRIVATE


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> Cmd.map ForSelf <| getList str driversDecoder GetDriversDone
