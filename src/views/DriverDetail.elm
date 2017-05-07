module Views.DriverDetail exposing (driverDetail)

import Html exposing (Html, div, h3, text)

import Messages exposing (Msg (..))
import Models exposing (Driver, Model)

driverDetail : Model -> Int -> Html Msg
driverDetail model id =
  let
    txt = case (findDriver model.drivers id) of
      Just d -> d.manufacturer.name ++ " " ++ d.model
      Nothing -> "Something went wrong"
  in
    div [] [ h3 [] [ text txt ]]
    -- basket_frame, bl_product, compliance_equivalent_volume, cone, cone_surface_area,
    -- created, dc_resistance, diaphragm_mass_including_airload, driver_product_listings,
    -- electromagnetic_q, frequency_response, id, in_production, magnet, manufacturer,
    -- max_linear_excursion, max_power, mechanical_compliance_of_suspension,
    -- mechanical_q, model, modified, nominal_impedance, resonant_frequency, rms_power,
    -- sensitivity, surround, voice_coil_diameter, voice_coil_former,
    -- voice_coil_inductance, voice_coil_wire

findDriver : List Driver -> Int -> Maybe Driver
findDriver drivers id =
  List.head <| List.filter (\d -> d.id == id) drivers
