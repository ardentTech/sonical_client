module Commands exposing (routeToCmd)

import Drivers.Commands exposing (getDriver, getDrivers, getDriversWithParams)
import Manufacturing.Commands exposing (getManufacturers)
import Messages exposing (childTranslator, Msg (..))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))


routeToCmd : Model -> Cmd Msg
routeToCmd model =
  let
    toDriversMsg = (\v -> Cmd.map DriversMsg <| v)
    toManufacturingMsg = (\v -> Cmd.map ManufacturingMsg <| v)
  in
    case model.currentRoute of
      Nothing -> Cmd.none
      Just (DriverList Nothing) ->
        toDriversMsg (getDrivers model)
      Just (DriverList (Just q)) ->
        toDriversMsg (getDriversWithParams model q)
      Just (DriverDetail i) ->
        toDriversMsg (getDriver model i)
      Just ManufacturerList ->
        toManufacturingMsg (getManufacturers model)
