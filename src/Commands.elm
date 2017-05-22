module Commands exposing (
  getDrivers,
  getDriversNextPage,
  getDriversPreviousPage,
  queryDrivers,
  routeToCmd)

import Api exposing (driverUrl, driversUrl, manufacturersUrl)
import Decoders exposing (driverDecoder, driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (..))
import Models exposing (Model)
import Rest exposing (getItem, getList)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))


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


getDriversNextPage : Model -> Cmd Msg
getDriversNextPage model =
  getDriversPage model.driversNextPage


getDriversPreviousPage : Model -> Cmd Msg
getDriversPreviousPage model =
  getDriversPage model.driversPreviousPage


getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    url = (manufacturersUrl model.apiUrl) ++ "?limit=100"
  in
    getList url manufacturersDecoder GetManufacturersDone


-- @todo convert manufacturer name to id
-- @todo validate input?
-- @todo materials
queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    query =
      case String.startsWith "?" model.driversQuery of
        True -> model.driversQuery
        False -> "?" ++ model.driversQuery
  in
    getList ((driversUrl model.apiUrl) ++ query) driversDecoder GetDriversDone


routeToCmd : Model -> Cmd Msg
routeToCmd model =
  case model.currentRoute of
    Nothing -> Cmd.none
    Just (DriverList Nothing) -> getDrivers model
    Just (DriverList (Just limit)) -> getDrivers model
    Just (DriverDetail i) -> getDriver model i
    Just ManufacturerList -> getManufacturers model


-- PRIVATE


getDriversPage : Maybe String -> Cmd Msg
getDriversPage page =
  case page of
    Nothing -> Cmd.none
    Just str -> getList str driversDecoder GetDriversDone
