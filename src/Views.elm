module Views exposing (view)

import Html exposing (Html, button, div, form, h1, input, text)
import Html.Attributes exposing (class, disabled, id, placeholder, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import List exposing (length)
import Table exposing (defaultCustomizations)

import Messages exposing (Msg (..))
import Models exposing (Driver, Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
import Units exposing (decibels, hertz, inches, ohms, watts)


view : Model -> Html Msg
view model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      h1 [] [ text "Drivers" ],
      form [ onSubmit NoOp ] [
        div [ class "form-group" ] [
          input [
              class "form-control",
              placeholder "Model",
              onInput QueryInput,
              type_ "text",
              value model.driversQuery ] []
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
      maybeFloatColumn "Diam" .nominal_diameter inches,
      maybeFloatColumn "Fs" .resonant_frequency hertz,
      maybeFloatColumn "SPL" .sensitivity decibels,
      maybeIntColumn "Z"  .nominal_impedance ohms,
      maybeIntColumn "Max P" .max_power watts,
      maybeIntColumn "RMS P" .rms_power watts ],
    customizations = {
      defaultCustomizations | tableAttrs = [ class "table table-sm table-striped" ]
    }
  }


maybeFloatColumn : String -> (Driver -> Maybe Float) -> String -> Table.Column Driver Msg
maybeFloatColumn name toData unit=
  let
    data = maybeFloatToFloat << toData
  in
    Table.customColumn {
      name = name,
      viewData = (\v -> appendUnit (data v) unit),
      sorter = Table.increasingOrDecreasingBy data 
    }


maybeIntColumn : String -> (Driver -> Maybe Int) -> String -> Table.Column Driver Msg
maybeIntColumn name toData unit=
  let
    data = maybeIntToInt << toData
  in
    Table.customColumn {
      name = name,
      viewData = (\v -> appendUnit (data v) unit),
      sorter = Table.increasingOrDecreasingBy data 
    }


appendUnit : number -> String -> String
appendUnit n unit =
  (toString n) ++ " " ++ unit
