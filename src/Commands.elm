module Commands exposing (getDrivers, searchDrivers)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder)
import Messages exposing (Msg (GetDriversDone))
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


searchDrivers : Model -> String -> Cmd Msg
searchDrivers model query =
  let
    url = (driversUrl model) ++ "?search=" ++ query
  in
    getDrivers model (Just url)
