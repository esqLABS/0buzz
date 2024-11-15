box::use(config)

#' @export
ORGAN_TAB <- config$get("tab_items", config = "organ_tab")

#' @export
GENDERS <- c("male", "female")

#' @export
POPULATIONS <- c("European", "White American", "Black American", "Mexican American", "Asian", "Japanese")

#' @export
DRINK_TYPES <- list(
  # Coffee types
  "Espresso" = list(caffeine = 64, water = 30),             # Single shot (30 mL)
  "Double Espresso" = list(caffeine = 128, water = 60),     # Double shot (60 mL)
  "Americano" = list(caffeine = 64, water = 240),           # Espresso with water (240 mL)
  "Latte" = list(caffeine = 64, water = 240),               # Espresso with steamed milk (240 mL)
  "Cappuccino" = list(caffeine = 64, water = 180),          # Espresso with steamed milk & foam (180 mL)
  "Flat White" = list(caffeine = 64, water = 160),          # Espresso with steamed milk (160 mL)
  "Mocha" = list(caffeine = 64, water = 240),               # Espresso with chocolate & milk (240 mL)
  "Macchiato" = list(caffeine = 64, water = 45),            # Espresso with a dash of milk (45 mL)
  "Ristretto" = list(caffeine = 64, water = 15),            # Shorter espresso shot (15 mL)
  "Lungo" = list(caffeine = 64, water = 60),                # Extended espresso shot (60 mL)
  "Drip Coffee" = list(caffeine = 95, water = 240),         # Standard brew (240 mL)
  "Cold Brew" = list(caffeine = 100, water = 240),          # Coarse-ground steeped (240 mL)
  "Iced Coffee" = list(caffeine = 95, water = 240),         # Drip coffee served cold (240 mL)
  "French Press" = list(caffeine = 80, water = 240),        # Coarse-ground press (240 mL)
  "Turkish Coffee" = list(caffeine = 60, water = 60),       # Fine-ground simmered (60 mL)

  # Decaf coffee options
  "Decaf Espresso" = list(caffeine = 2, water = 30),        # Single shot decaf (30 mL)
  "Decaf Drip Coffee" = list(caffeine = 5, water = 240),    # Standard brew decaf (240 mL)
  "Decaf Americano" = list(caffeine = 2, water = 240),      # Decaf espresso with water (240 mL)

  # Teas
  "Black Tea" = list(caffeine = 47, water = 240),           # Steeped black tea (240 mL)
  "Green Tea" = list(caffeine = 28, water = 240),           # Steeped green tea (240 mL)
  "White Tea" = list(caffeine = 15, water = 240),           # Steeped white tea (240 mL)
  "Oolong Tea" = list(caffeine = 37, water = 240),          # Steeped oolong tea (240 mL)
  "Matcha" = list(caffeine = 70, water = 60),               # Fine powder green tea (60 mL)
  "Chai Tea" = list(caffeine = 50, water = 240),            # Spiced black tea (240 mL)
  "Herbal Tea" = list(caffeine = 0, water = 240),           # Herbal infusion (240 mL)
  "Rooibos Tea" = list(caffeine = 0, water = 240)           # Caffeine-free rooibos (240 mL)
)

#' @export
METABOLISM = c("low", "normal", "high")

#' @export
UNITS <- c("metric", "imperial")
