module Rest exposing (HttpListResponse, getItem, getList)

import Http
import Json.Decode exposing (Decoder, int, nullable, string)
import Json.Decode.Pipeline exposing (decode, required)
import Result exposing (Result)


type alias HttpListResponse a = {
  count : Int,
  next : Maybe String,
  previous : Maybe String,
  results : List a
}


getItem : String -> Decoder a -> (Result Http.Error a -> b) -> Cmd b
getItem url itemDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url itemDecoder


getList : String -> Decoder (List a) -> (Result Http.Error (HttpListResponse a) -> b) -> Cmd b
getList url listDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url (httpListResponseDecoder listDecoder)


-- PRIVATE


httpListResponseDecoder : Decoder (List a) -> Decoder (HttpListResponse a)
httpListResponseDecoder listDecoder = decode HttpListResponse
  |> required "count" int
  |> required "next" (nullable string)
  |> required "previous" (nullable string)
  |> required "results" listDecoder
