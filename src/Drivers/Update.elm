module Drivers.Update exposing (update)

import Regex exposing (..)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (..)
import Models exposing (Model)
import Rest exposing (httpErrorString)


extractOffset : Maybe String -> Maybe Int
extractOffset haystack =
  let
    matcher = (\h ->
      List.head <| List.map .match (find (AtMost 1) (regex ("offset=(\\d+)")) h))
  in
    case haystack of
      Just h -> case (matcher h) of
        Just v -> case (List.head <| List.reverse <| String.split "=" v) of
          Just t -> case String.toInt t of
            Ok i -> Just i
            Err _ -> Nothing
          Nothing -> Nothing
        Nothing -> Nothing
      Nothing -> Nothing


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetDriverDone (Ok driver) ->
      ({ model | driver = Just driver }, Cmd.none )
    GetDriverDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    GetDriversDone (Ok response) ->
      let
        nextOffset = extractOffset response.next
        previousOffset = extractOffset response.previous
      in
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextOffset = nextOffset,
          driversPreviousOffset = previousOffset
        }, Cmd.none )
    GetDriversDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    NextPageClicked ->
      -- @todo
        ( model, Cmd.none )
    PrevPageClicked ->
      -- @todo
      ( model, Cmd.none )
    QueryBuilderCleared ->
      ({ model | driversQuery = "" }, Cmd.none )
    QueryBuilderHelpClicked ->
      let
        showHelp = not model.driversQueryBuilderHelp
      in
        ({ model | driversQueryBuilderHelp = showHelp }, Cmd.none )
    QueryBuilderSubmitted ->
      ( model, queryDrivers model )
    QueryBuilderUpdated val ->
      ({ model | driversQuery = val }, Cmd.none )
    SetTableState newState ->
      ({ model | tableState = newState }, Cmd.none )
