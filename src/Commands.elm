module Commands exposing (getDrivers)

import Http
import Result exposing (Result)

import Constants exposing (apiUrl)
import Decoders exposing (httpResponseDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (HttpResponse)


getDrivers : Maybe String -> Cmd Msg
getDrivers url =
  let
    endpoint =
      case url of
        Nothing -> apiUrl ++ "/drivers/"
        Just s -> s
  in
    get endpoint GetDriversDone


get : String -> (Result Http.Error HttpResponse -> b) -> Cmd b
get url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
