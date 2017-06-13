module Drivers.Update exposing (update)

import Regex exposing (..)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (..)
import Drivers.QueryParams exposing (getOffset)
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
        Debug.log(toString nextOffset)
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextOffset = nextOffset,
          driversPreviousOffset = previousOffset
        }, Cmd.none )
    GetDriversDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    NextPageClicked ->
      let
        driversQuery = offsetToDriversQuery model.driversNextOffset model.driversQuery
      in
        ({ model | driversQuery = driversQuery }, Cmd.none )
    PrevPageClicked ->
      let
        driversQuery = offsetToDriversQuery model.driversPreviousOffset model.driversQuery
      in
        ({ model | driversQuery = driversQuery }, Cmd.none )
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


-- PRIVATE


offsetToDriversQuery : Maybe Int -> String -> String
offsetToDriversQuery offset query =
  case offset of
    Just o ->
      case getOffset <| Just query of
        Just i -> "OFFSET IN QUERY, SO REPLACE"
        Nothing -> "OFFSET NOT IN QUERY, SO ADD"
    Nothing -> query
