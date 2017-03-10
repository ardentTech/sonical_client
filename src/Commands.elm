module Commands exposing (getDrivers, searchDrivers)

import Http
import Result exposing (Result)

import Constants exposing (apiUrl)
import Decoders exposing (httpResponseDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (HttpResponse)


driversUrl : String
driversUrl = apiUrl ++ "/drivers/"


getDrivers : Maybe String -> Cmd Msg
getDrivers url =
  let
    endpoint =
      case url of
        Nothing -> driversUrl
        Just s -> s
  in
    get endpoint GetDriversDone


searchDrivers : String -> Cmd Msg
searchDrivers query =
  let
    url = driversUrl ++ "?search=" ++ query
  in
    getDrivers (Just url)


get : String -> (Result Http.Error HttpResponse -> b) -> Cmd b
get url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
