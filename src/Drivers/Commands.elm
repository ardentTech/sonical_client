module Drivers.Commands exposing (getDriver, getDrivers)

import Api exposing (driverUrl, driversUrl)
import Drivers.Decoders exposing (driverDecoder, driversDecoder)
import Drivers.Messages exposing (..)
import Models exposing (Model)
import QueryParams exposing (toUrl)
import Rest exposing (getItem, getList)


-- @todo HTTP request should update the URL


getDriver : Model -> Int -> Cmd Msg
getDriver model i =
  let
    url = driverUrl model.apiUrl i
  in
    Cmd.map ForSelf <| getItem url driverDecoder GetDriverDone


getDrivers : Model -> Cmd Msg
getDrivers model =
  let
    url = driversUrl model.apiUrl ++ (toUrl model.queryParams)
  in
    Cmd.map ForSelf <| getList url driversDecoder GetDriversDone
