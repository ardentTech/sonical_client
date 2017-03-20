module Rest exposing (getList)

import Http
import Result exposing (Result)

import Decoders exposing (httpResponseDecoder)
import Models exposing (Driver, ListHttpResponse)


getList : String -> (Result Http.Error (ListHttpResponse Driver) -> b) -> Cmd b
getList url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
