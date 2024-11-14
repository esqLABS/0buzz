const { useState, useEffect } = React;
const Dropdown = require('./components/Dropdown.js').default;
const GenderSwitch = require('./components/GenderSwitch.js').default;
const NumericSlider = require('./components/NumericSlider.js').default;
const CategoricalSlider = require('./components/CategoricalSlider.js').default;
const SmokerCheckbox = require('./components/SmokerCheckbox.js').default;

export default function EditUserdata({id, init_shiny_data, ethinicity_options, metabolism_options, unit_options}) {
  console.log("initShinyData: ", init_shiny_data);

  const [shinyData, setShinyData] = useState({
        ethnicity: init_shiny_data.ethnicity,
        gender: init_shiny_data.gender,
        age: init_shiny_data.age,
        height: init_shiny_data.height,
        weight: init_shiny_data.weight,
        unit: init_shiny_data.unit,
        metabolism: init_shiny_data.metabolism,
        smoker: init_shiny_data.smoker
    });

    const handleSliderChange = (identifier, value) => {
        const updatedData = { ...shinyData, [identifier]: value };
        setShinyData(prevData => ({
            ...prevData,
            [identifier]: value
        }));
        Shiny.setInputValue(id, updatedData);
    };





    return(
      <div id={id}>
            <p className="user-input-title">Ethinicity:</p>
            <Dropdown initialValue={init_shiny_data.ethnicity}
                      dropdownOptions={ethinicity_options}
                      onChange={
                        (value) => handleSliderChange('ethnicity', value)
                      }
            />
            <p className="user-input-title">Gender:</p>
            <GenderSwitch initialValue={init_shiny_data.gender}
                          onChange={
                            (value) => handleSliderChange('gender', value)
                          }
            />
            <p className="user-input-title">Age:</p>
            <NumericSlider
              min={5}
              max={105}
              step={1}
              initialValue={init_shiny_data.age}
              onChange={
                (value) => handleSliderChange('age', value)
              }
              unit="imperial"
              measure=""
            />
            <p className="user-input-title">Height:</p>
            <NumericSlider
              min={shinyData.unit.toLowerCase() == "imperial" ? 39 : 1.00}
              max={shinyData.unit.toLowerCase() == "imperial" ? 87 : 2.20}
              step={shinyData.unit.toLowerCase() == "imperial" ? 1 : 0.01}
              initialValue={init_shiny_data.height}
              onChange={
                (value) => handleSliderChange('height', value)
              }
              unit="imperial"
              measure={shinyData.unit.toLowerCase() == "imperial" ? "in" : "cm"}
            />

            <p className="user-input-title">Weight:</p>
            <NumericSlider
              min={shinyData.unit.toLowerCase() == "imperial" ? 22 : 10}
              max={shinyData.unit.toLowerCase() == "imperial" ? 462 : 210}
              step={shinyData.unit.toLowerCase() == "imperial" ? 10 : 1}
              initialValue={init_shiny_data.weight}
              onChange={
                (value) => handleSliderChange('weight', value)
              }
              unit="imperial"
              measure={shinyData.unit.toLowerCase() == "imperial" ? "lbs" : "kg"}
            />

            <p className="user-input-title">Metabolism:</p>
            <CategoricalSlider
              options={metabolism_options}
              initialValue={init_shiny_data.metabolism}
              onChange={
                (value) => handleSliderChange('metabolism', value)
              }
            />
            <SmokerCheckbox
              initialChecked={init_shiny_data.smoker}
              onChange={
                (value) => handleSliderChange('smoker', value)
              }
            />
            <p className="user-input-title">Unit:</p>
            <CategoricalSlider
              options={unit_options}
              initialValue={init_shiny_data.unit}
              onChange={
                (value) => handleSliderChange('unit', value)
              }
            />

      </div>
    );

}
