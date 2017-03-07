module Update exposing (update)

import Commands exposing (fetchDrivers)
import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      FetchDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextPage = response.next,
          driversPreviousPage = response.previous
        }, Cmd.none )
      FetchDriversDone (Err _) ->
        ( model, Cmd.none )
      NextPageClicked ->
        ( model, fetchDrivers model.driversNextPage )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, fetchDrivers model.driversPreviousPage )
      TableHeaderClicked columnId ->
        -- @todo handle inverting the sort direction
        ({ model | driversSortBy = columnId }, Cmd.none )
