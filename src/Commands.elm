module Commands exposing (getDrivers, getManufacturers, searchDrivers)

import Api exposing (driversUrl, manufacturersUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone, GetManufacturersDone))
import Models exposing (Model)
import Rest exposing (getList)


getDrivers : Model -> Maybe String -> Cmd Msg
getDrivers model url =
  let
    endpoint =
      case url of
        Nothing -> driversUrl model
        Just s -> s
  in
    getList endpoint driversDecoder GetDriversDone


getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    endpoint = manufacturersUrl model
  in
    getList endpoint manufacturersDecoder GetManufacturersDone


searchDrivers : Model -> String -> Cmd Msg
searchDrivers model query =
  let
    url = (driversUrl model) ++ "?search=" ++ query
  in
    getDrivers model (Just url)
