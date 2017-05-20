module Update exposing (update)

import Http exposing (Error (..))
import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Commands exposing (..)
import Messages exposing (Msg (..))
import Models exposing (Model)
import Router exposing (route)


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      ErrorDismissed ->
        ({ model | errorMessage = "" }, Cmd.none )
      Fail _ ->
        ( model, Cmd.none )
      GetDriverDone (Ok driver) ->
        ({ model | driver = Just driver }, Cmd.none )
      GetDriverDone (Err error) ->
        ({ model | errorMessage = httpErrorString error }, Cmd.none )
      GetDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextPage = response.next,
          driversPreviousPage = response.previous
        }, Cmd.none )
      GetDriversDone (Err error) ->
        ({ model | errorMessage = httpErrorString error }, Cmd.none )
      NextPageClicked ->
        ( model, getDriversNextPage model )
      NewUrl url ->
        ( model, newUrl url )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, getDriversPreviousPage model )
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
      UrlChange location ->
        let
          newRoute = parsePath route location
          newModel = { model | currentRoute = newRoute }
        in
          if (model.currentRoute == newRoute) then
            (model, Cmd.none)
          else
            (newModel, routeToCmd newModel )
