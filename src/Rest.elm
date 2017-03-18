module Rest exposing (get)

import Http
import Result exposing (Result)

import Decoders exposing (httpResponseDecoder)
import Models exposing (HttpResponse)


get : String -> (Result Http.Error HttpResponse -> b) -> Cmd b
get url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
