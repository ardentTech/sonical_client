module Commands exposing (cmdFromRoute)

import Drivers.Commands exposing (getDriver, getDrivers, getDriversWithParams)
import Manufacturing.Commands exposing (..)
import Messages exposing (..)
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))


cmdFromRoute : Model -> Cmd Msg
cmdFromRoute model =
  let
    toDriversMsg = (\v -> Cmd.map DriversMsg <| v)
  in
    case model.currentRoute of
      Just (DriverList Nothing) ->
        Cmd.map driversTranslator (getDrivers model)
      Just (DriverList (Just q)) ->
        Cmd.map driversTranslator (getDriversWithParams model q)
      Just (DriverDetail i) ->
        Cmd.map driversTranslator (getDriver model i)
      Just ManufacturerList ->
        Cmd.map childTranslator <| manufacturingRouteToCmd model
      _ -> Cmd.none
