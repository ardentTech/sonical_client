module Commands exposing (routeToCmd)

import Drivers.Commands exposing (getDriver, getDrivers, getDriversWithParams)
import Manufacturers.Commands exposing (getManufacturers)
import Messages exposing (Msg)
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))


routeToCmd : Model -> Cmd Msg
routeToCmd model =
  case model.currentRoute of
    Nothing -> Cmd.none
    Just (DriverList Nothing) -> getDrivers model
    Just (DriverList (Just q)) -> getDriversWithParams model q
    Just (DriverDetail i) -> getDriver model i
    Just ManufacturerList -> getManufacturers model
