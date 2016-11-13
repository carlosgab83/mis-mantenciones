module MatrixImporter
  module Common
    class Constants
      VMES_SHEET_NAME = 'vmes'
      TITLES_ROW = 1
      FIRST_KMS_INDEX = 2
      VME_VARIANTS = {
        "000" => {diesel_engine: false, double_traction: false, automatic_transmission: false},
        "001" => {diesel_engine: false, double_traction: false, automatic_transmission: true},
        "010" => {diesel_engine: false, double_traction: true, automatic_transmission: false},
        "011" => {diesel_engine: false, double_traction: true, automatic_transmission: true},
        "100" => {diesel_engine: true, double_traction: false, automatic_transmission: false},
        "101" => {diesel_engine: true, double_traction: false, automatic_transmission: true},
        "110" => {diesel_engine: true, double_traction: true, automatic_transmission: false},
        "111" => {diesel_engine: true, double_traction: true, automatic_transmission: true},
      }
    end
  end
end
