module Update exposing (update)

import Commands exposing (..)
import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      GetDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextPage = response.next,
          driversPreviousPage = response.previous
        }, Cmd.none )
      GetDriversDone (Err _) ->
        ( model, Cmd.none )
      NextPageClicked ->
        ( model, getDriversNextPage model )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, getDriversPreviousPage model )
      QueryBuilderCleared ->
        ({ model | queryBuilderVal = "" }, Cmd.none )
      QueryBuilderSubmitted ->
        ( model, queryDrivers model )
      QueryBuilderUpdated val ->
        ({ model | queryBuilderVal = val }, Cmd.none )
      SetTableState newState ->
        ({ model | tableState = newState }, Cmd.none )
