box::use(
  ospsuite,
  rlang,
  dplyr[case_match]
)

box::use(
  app / logic / constants[POPULATIONS, GENDERS],
)

set_individual <- function(simulation, user_data) {
  message("Applying individual characteristics to the simulation")
  # Create individual
  individual <- create_individual(user_data)
  # Apply individual parameters to the simulation
  ospsuite::setParameterValuesByPath(
    parameterPaths = individual$distributedParameters$paths,
    values         = individual$distributedParameters$values,
    simulation     = simulation
  )

  # Set CYP1A2 concentration to reflect metabolism and Smoker status
  CYP1A2_ref_conc <- ospsuite::getParameter("CYP1A2|Reference concentration", simulation)$value # default is 1.8

  # Metabolism level
  metabolism_factor <- case_match(
    user_data$metabolism,
    "low" ~ 0.2,
    "normal" ~ 1,
    "high" ~ 5
  )

  # Smoker status
  smoker_factor <- if (user_data$smoker) 3.5 else 1

  ospsuite::setParameterValuesByPath(
    parameterPaths = "CYP1A2|Reference concentration",
    values         = CYP1A2_ref_conc * metabolism_factor * smoker_factor,
    unit           = "µmol/l",
    simulation     = simulation
  )
}

create_individual <- function(user_data) {
  unit_system <- user_data$unit
  ind_carac <- ospsuite::createIndividualCharacteristics(
    species = "Human",
    population = translate_population(user_data$ethnicity),
    gender = translate_gender(user_data$gender),
    age = as.double(user_data$age),
    weight = convert_weight(user_data$weight, unit_system),
    height = convert_height(user_data$height, unit_system),
    seed = 42
  )
  return(ospsuite::createIndividual(ind_carac))
}

translate_population <- function(population) {
  rlang::arg_match(population, POPULATIONS)
  case_match(
    population,
    "European" ~ ospsuite::HumanPopulation$European_ICRP_2002,
    "White American" ~ ospsuite::HumanPopulation$WhiteAmerican_NHANES_1997,
    "Black American" ~ ospsuite::HumanPopulation$BlackAmerican_NHANES_1997,
    "Mexican American" ~ ospsuite::HumanPopulation$MexicanAmericanWhite_NHANES_1997,
    "Asian" ~ ospsuite::HumanPopulation$Asian_Tanaka_1996,
    "Japanese" ~ ospsuite::HumanPopulation$Japanese_Population
  )
}

translate_gender <- function(gender) {
  rlang::arg_match(gender, GENDERS)
  case_match(
    gender,
    "male" ~ ospsuite::Gender$Male,
    "female" ~ ospsuite::Gender$Female
  )
}
convert_height <- function(height, unit_system) {
  height <- if (unit_system == "imperial") {
    # feet to cm
    height * 30.48
  } else {
    # meters to cm
    height * 100
  }
  return(as.double(height))
}

convert_weight <- function(weight, unit_system) {
  weight <- if (unit_system == "imperial") {
    # lbs to kg
    weight * 0.453592
  } else { weight }
  return(as.double(weight))
}
