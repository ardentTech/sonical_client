module Rest exposing (getList)

import Http
import Result exposing (Result)

import Decoders exposing (httpResponseDecoder)
import Models exposing (ListHttpResponse)


getList : String -> (Result Http.Error ListHttpResponse -> b) -> Cmd b
getList url resultToMsg =
  Http.send resultToMsg <| Http.get url httpResponseDecoder
