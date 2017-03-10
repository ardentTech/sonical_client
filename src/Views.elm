module Views exposing (view)

import Html exposing (Html, button, div, form, h1, input, text)
import Html.Attributes exposing (class, disabled, id, placeholder, type_)
import Html.Events exposing (onClick, onInput)
import List exposing (length)
import Table exposing (defaultCustomizations)

import Messages exposing (
  Msg (NextPageClicked, PrevPageClicked, SetDriversQuery, SetTableState))
import Models exposing (Driver, Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
import Units exposing (decibels, hertz, ohms, watts)


view : Model -> Html Msg
view model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      h1 [] [ text "Drivers" ],
      form [] [
        div [ class "form-group" ] [
          input [
              class "form-control",
              placeholder "Search by Model",
              onInput SetDriversQuery,
              type_ "text" ] []
        ]
      ],
      Table.view tableConfig model.tableState model.drivers
    ], 
    div [ class "col-6", id "pagination-info" ] [ paginationInfo model ],
    div [ class "col-6", id "pagination-controls" ] [ paginationControls model ]
    ]


-- PRIVATE


manufacturerColumn : Table.Column Driver Msg
manufacturerColumn =
  Table.stringColumn "Manufacturer" ((\m -> m.name) << .manufacturer)


maybeFloatColumn : String -> (a -> Maybe Float) -> Table.Column a Msg
maybeFloatColumn name a =
  Table.floatColumn name (maybeFloatToFloat << a)


maybeIntColumn : String -> (a -> Maybe Int) -> Table.Column a Msg
maybeIntColumn name a =
  Table.intColumn name (maybeIntToInt << a)


paginationControl : Maybe String -> Msg -> String -> Html Msg
paginationControl endpoint msg txt =
  let
    disabledVal =
      case endpoint of
        Nothing -> True
        Just e -> False
  in
    button [
      class "btn btn-secondary btn-sm text-muted",
      disabled disabledVal,
      onClick msg
    ] [ text txt ]


paginationControls : Model -> Html Msg
paginationControls model =
  let
    prev = paginationControl model.driversPreviousPage PrevPageClicked "«"
    next = paginationControl model.driversNextPage NextPageClicked "»"
  in
    div [ class "btn-group float-right" ] [ prev, next ]


paginationInfo : Model -> Html Msg
paginationInfo model =
  let
    currentCount = (toString <| length model.drivers)
    totalCount = (toString model.driversCount)
  in
    div [ class "text-muted" ] [
      text <| "Showing " ++ currentCount ++ " of " ++ totalCount ++ " items"
    ]


tableConfig : Table.Config Driver Msg
tableConfig =
  Table.customConfig {
    toId = .model,
    toMsg = SetTableState,
    columns = [
      manufacturerColumn,
      Table.stringColumn "Model" .model,
      maybeFloatColumn ("Fs (" ++ hertz ++ ")") .resonant_frequency,
      maybeFloatColumn ("SPL (" ++ decibels ++ ")") .sensitivity,
      maybeIntColumn ("Z (" ++ ohms ++ ")")  .nominal_impedance,
      maybeIntColumn ("Max (" ++ watts ++ ")") .max_power,
      maybeIntColumn ("RMS (" ++ watts ++ ")") .rms_power ],
    customizations = {
      defaultCustomizations | tableAttrs = [ class "table table-sm table-striped" ]
    }
  }
