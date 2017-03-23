module Commands exposing (
  getDrivers, getDriversByManufacturer, getManufacturers, searchDrivers)

import Api exposing (driversUrl, manufacturersUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone, GetManufacturersDone))
import Models exposing (Model)
import Rest exposing (getList)


-- @todo this module sucks. refactor it.


getDrivers : Model -> Maybe String -> Cmd Msg
getDrivers model url =
  let
    endpoint =
      case url of
        Nothing -> driversUrl model
        Just s -> s
  in
    getList endpoint driversDecoder GetDriversDone


getDriversByManufacturer : Model -> Int -> Cmd Msg
getDriversByManufacturer model id =
  if id > 0 then
    let
      search =
        case String.length model.driversQuery of
          0 -> ""
          _ -> "&search=" ++ model.driversQuery
      url = (driversUrl model) ++ "?manufacturer=" ++ (toString id) ++ search
    in
      getDrivers model (Just url)
  else
    Cmd.none
    -- @todo handle situation where manufacturer id == 0 and there IS a search query



getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    endpoint = manufacturersUrl model
  in
    getList endpoint manufacturersDecoder GetManufacturersDone


searchDrivers : Model -> String -> Cmd Msg
searchDrivers model query =
  let
    manufacturer =
      case model.selectedManufacturer of
        0 -> ""
        _ -> "&manufacturer=" ++ (toString model.selectedManufacturer)
    url = (driversUrl model) ++ "?search=" ++ query ++ manufacturer
  in
    getDrivers model (Just url)
