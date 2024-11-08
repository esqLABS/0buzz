box::use(
  ospsuite,
  rlang,
  dplyr[case_match]
)

set_individual <- function(simulation, user_data) {
  # Create individual
  individual <- create_individual(user_data)
  # Apply individual parameters to the simulation
  ospsuite::setParameterValuesByPath(
    parameterPaths = individual$distributedParameters$paths,
    values         = individual$distributedParameters$values,
    simulation     = simulation
  )
}

create_individual <- function(user_data) {
  ind_carac <- ospsuite::createIndividualCharacteristics(
    species = "Human",
    population = translate_population(user_data$ethnicity),
    gender = translate_gender(user_data$gender),
    age = as.double(user_data$age),
    weight = as.double(user_data$weight),
    height = as.double(convert_height(user_data$height)),
    seed = 42
  )
  return(ospsuite::createIndividual(ind_carac))
}

translate_population <- function(population) {
  rlang::arg_match(population, c("European", "White American", "Black American", "Mexican American", "Asian", "Japanese"))
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
  rlang::arg_match(gender, c("male", "female"))
  case_match(
    gender,
    "male" ~ ospsuite::Gender$Male,
    "female" ~ ospsuite::Gender$Female
  )
}

convert_height <- function(height) {
  # meters to cm
  return(height * 100)
}
