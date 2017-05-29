module Rest exposing (HttpListResponse, getItem, getList, httpErrorString)

import Http exposing (Error (..))
import Json.Decode exposing (Decoder, int, nullable, string)
import Json.Decode.Pipeline exposing (decode, required)
import Result exposing (Result)


type alias HttpListResponse a = {
  count : Int,
  next : Maybe String,
  previous : Maybe String,
  results : List a
}


getItem : String -> Decoder a -> (Result Error a -> b) -> Cmd b
getItem url itemDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url itemDecoder


getList : String -> Decoder (List a) -> (Result Error (HttpListResponse a) -> b) -> Cmd b
getList url listDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url (httpListResponseDecoder listDecoder)


httpErrorString : Error -> String
httpErrorString error =
  case error of
    BadUrl text ->
      "Bad Url: " ++ text
    Timeout ->
      "Http Timeout"
    NetworkError ->
      "Network Error"
    BadStatus response ->
      "Bad HTTP Status: " ++ toString response.status.code
    BadPayload message response ->
      "Bad HTTP Payload: " ++ toString message ++ " (" ++
      toString response.status.code ++ ")"


-- PRIVATE


httpListResponseDecoder : Decoder (List a) -> Decoder (HttpListResponse a)
httpListResponseDecoder listDecoder = decode HttpListResponse
  |> required "count" int
  |> required "next" (nullable string)
  |> required "previous" (nullable string)
  |> required "results" listDecoder
