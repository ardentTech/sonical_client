module Update exposing (update)

import Commands exposing (getDrivers, searchDrivers)
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
        ( model, getDrivers model.driversNextPage )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, getDrivers model.driversPreviousPage )
      SetDriversQuery query ->
        ({ model | driversQuery = query }, searchDrivers query )
      SetTableState newState ->
        ({ model | tableState = newState }, Cmd.none )
