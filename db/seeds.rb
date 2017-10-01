# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
system_setting = SystemSetting.first || SystemSetting.create(
  product_scraping_caching_minutes: 1,
  default_latitude: -33.455388,
  default_longitude: -70.634216,
  default_zoom: 12,
  landing_title: 'Los mejores servicios para tu auto cerca de tu ubicación'
)