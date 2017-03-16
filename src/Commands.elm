module Commands exposing (getDrivers, searchDrivers)

import Http
import Result exposing (Result)

import Decoders exposing (httpResponseDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (HttpResponse, Model)


driversUrl : String
driversUrl = "/drivers/"


getDrivers : Model -> Maybe String -> Cmd Msg
getDrivers model url =
  let
    endpoint =
      case url of
        Nothing -> model.apiUrl ++ driversUrl
        Just s -> s
  in
    get endpoint GetDriversDone


searchDrivers : Model -> String -> Cmd Msg
searchDrivers model query =
  let
    url = model.apiUrl ++ driversUrl ++ "?search=" ++ query
  in
    getDrivers model (Just url)


get : String -> (Result Http.Error HttpResponse -> b) -> Cmd b
get url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
