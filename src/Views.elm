module Views exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, onSubmit)
import Table exposing (defaultCustomizations)

import Messages exposing (Msg (..))
import Models exposing (Driver, Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
import Units exposing (decibels, hertz, inches, ohms, watts)


-- @todo need to load specific subview off of model.currentRoute
view : Model -> Html Msg
view model =
  let
    alert =
      case String.length model.errorMessage > 0 of
        True ->  div [ class "alert alert-danger" ] [
            button [ class "close", onClick ErrorDismissed, type_ "button" ] [
              span [] [ text "×" ]],
            strong [] [ text "Error! " ],
            text model.errorMessage
          ]
        False -> text ""
  in
    div [ class "row" ] [
      div [ class "col-12" ] [
        alert,
        h1 [] [ text "Drivers" ]
      ],
      div [ class "col-12" ] [
        queryBuilder model,
        Table.view tableConfig model.tableState model.drivers
      ], 
      div [ class "col-6", id "pagination-info" ] [ paginationInfo model ],
      div [ class "col-6", id "pagination-controls" ] [ paginationControls model ]
      ]


-- PRIVATE


appendUnit : number -> String -> String
appendUnit n unit =
  (toString n) ++ " " ++ unit


manufacturerColumn : Table.Column Driver Msg
manufacturerColumn =
  Table.stringColumn "Manufacturer" ((\m -> m.name) << .manufacturer)


modelColumn : Table.Column Driver Msg
modelColumn =
  Table.veryCustomColumn {
    name = "Model",
    viewData = viewModel,
    sorter = Table.unsortable
  }


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
    currentCount = (toString <| List.length model.drivers)
    totalCount = (toString model.driversCount)
  in
    div [ class "text-muted" ] [
      text <| "Showing " ++ currentCount ++ " of " ++ totalCount ++ " items"
    ]


maybeFloatColumn : String -> (Driver -> Maybe Float) -> String -> Table.Column Driver Msg
maybeFloatColumn name toData unit =
  let
    data = maybeFloatToFloat << toData
    formatData = (\d -> if d > 0 then (appendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }


maybeIntColumn : String -> (Driver -> Maybe Int) -> String -> Table.Column Driver Msg
maybeIntColumn name toData unit =
  let
    data = maybeIntToInt << toData
    formatData = (\d -> if d > 0 then (appendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }


queryBuilder : Model -> Html Msg
queryBuilder model =
  div [ id "query-builder", onSubmit QueryBuilderSubmitted ] [
    Html.form [ class "clearfix" ] [
      div [ class "form-group" ] [
        textarea [
          class "form-control",
          onInput QueryBuilderUpdated,
          placeholder "manufacturer=3",
          value model.driversQuery ] [ ]
      ],
      div [ class "float-right" ] [
        button [
            class "btn btn-md btn-secondary",
            onClick QueryBuilderCleared,
            type_ "button"
          ] [ text "Clear" ],
        button [
          class "btn btn-md btn-primary", type_ "submit" ] [ text "Submit" ]
      ]
    ]
  ]


tableConfig : Table.Config Driver Msg
tableConfig =
  Table.customConfig {
    toId = .model,
    toMsg = SetTableState,
    columns = [
      manufacturerColumn,
      modelColumn,
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


viewModel : Driver -> Table.HtmlDetails Msg
viewModel {model} =
  let
    limit = 30
    txt = (String.left limit model) ++ (if (String.length model > limit) then "..." else "")
  in
    Table.HtmlDetails [] [
      span [ title model ] [ text txt ]]
