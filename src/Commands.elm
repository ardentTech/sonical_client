module Commands exposing (fetchDrivers)

import Http

import Constants exposing (apiUrl)
import Decoders exposing (httpResponseDecoder)
import Messages exposing (Msg(FetchDriversDone))


fetchDrivers : Maybe String -> Cmd Msg
fetchDrivers url =
  let
    endpoint =
      case url of
        Nothing -> apiUrl ++ "/drivers/"
        Just s -> s
  in
    Http.send FetchDriversDone <| Http.get endpoint httpResponseDecoder
