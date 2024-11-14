box::use(config)

#' @export
ORGAN_TAB <- config$get("tab_items", config = "organ_tab")

#' @export
COFFEE_TYPES <- list(
  `Espresso` = list(caffeine = 64, water = 30),
  `Americano` = list(caffeine = 77, water = 30),
  `Cappuccino` = list(caffeine = 75, water = 180),
  `Latte` = list(caffeine = 63, water = 300),
  `Mocha` = list(caffeine = 95, water = 240),
  `Macchiato` = list(caffeine = 71, water = 30),
  `Ristretto` = list(caffeine = 75, water = 22),
  `Long Black` = list(caffeine = 77, water = 120),
  `Flat White` = list(caffeine = 77, water = 160),
  `Affogato` = list(caffeine = 64, water = 30),
  `Irish` = list(caffeine = 77, water = 150),
  `Turkish` = list(caffeine = 95, water = 240),
  `Greek` = list(caffeine = 95, water = 240),
  `Vietnamese` = list(caffeine = 77, water = 150),
  `Iced` = list(caffeine = 77, water = 150),
  `Decaf` = list(caffeine = 2, water = 240)
)
