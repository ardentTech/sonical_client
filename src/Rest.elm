module Rest exposing (getList)

import Http
import Result exposing (Result)

import Decoders exposing (httpResponseDecoder)
import Models exposing (HttpResponse)


getList : String -> (Result Http.Error HttpResponse -> b) -> Cmd b
getList url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
