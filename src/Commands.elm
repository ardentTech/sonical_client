module Commands exposing (routeToCmd)

import Drivers.Commands exposing (getDriver, getDrivers, getDriversWithParams)
import Manufacturing.Commands exposing (getManufacturers)
import Messages exposing (Msg (..))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))


routeToCmd : Model -> Cmd Msg
routeToCmd model =
  case model.currentRoute of
    Nothing -> Cmd.none
    Just (DriverList Nothing) ->
      Cmd.map DriversMsg <| getDrivers model
    Just (DriverList (Just q)) ->
      Cmd.map DriversMsg <| getDriversWithParams model q
    Just (DriverDetail i) ->
      Cmd.map DriversMsg <| getDriver model i
    Just ManufacturerList ->
      Cmd.map ManufacturingMsg <| getManufacturers model
