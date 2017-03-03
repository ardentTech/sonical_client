module Commands exposing (fetchDrivers)

import Http

import Constants exposing (apiUrl)
import Decoders exposing (httpResponseDecoder)
import Messages exposing (Msg(FetchDriversDone))


fetchDrivers : Cmd Msg
fetchDrivers =
  Http.send FetchDriversDone <| Http.get (apiUrl ++ "/drivers/") httpResponseDecoder
