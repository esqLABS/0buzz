const { useState } = React;
const Dropdown = require('./components/Dropdown.js').default;
const GenderSwitch = require('./components/GenderSwitch.js').default;
const NumericSlider = require('./components/NumericSlider.js').default;
const CategoricalSlider = require('./components/CategoricalSlider.js').default;
const SmokerCheckbox = require('./components/SmokerCheckbox.js').default;
const Intake = require('./components/Intake.js').default;

export default function Stepper({id, initShinyData, ethinicityOptions, metabolismOptions, coffeeTypeOptions, onComplete, unitOptions }) {
  const [step, setStep] = useState(1);

  console.log("initShinyData: ", initShinyData);

    const [shinyData, setShinyData] = useState({
        ethnicity: initShinyData.ethnicity,
        gender: initShinyData.gender,
        age: initShinyData.age,
        height: initShinyData.height,
        weight: initShinyData.weight,
        // intakes: initShinyData.intakes,
        unit: initShinyData.unit,
        metabolism: initShinyData.metabolism,
        smoker: initShinyData.smoker
    });
    const [intakes, setIntakes] = useState(initShinyData.intakes);
    const handleIntakeChange = (updatedIntakes) => {
        setIntakes(updatedIntakes);
        setShinyData(prevData => ({
            ...prevData,
            intakes: updatedIntakes
        }));
    };

    const handleAddIntake = () => {
        const newIntakes = [...intakes, { type: {}, time: '', selected: true }];
        setIntakes(newIntakes);
        setShinyData(prevData => ({
            ...prevData,
            intakes: newIntakes
        }));
    };

    const handleRemoveIntake = (indexToRemove) => {
      const updatedIntakes = intakes.filter((_, index) => index !== indexToRemove);
      setIntakes(updatedIntakes); // or however you're managing state
    };


    const handleSliderChange = (identifier, value) => {
        setShinyData(prevData => ({
            ...prevData,
            [identifier]: value
        }));
    };


    const handleNextStep = () => {
        if (step < 2) {
            setStep(step + 1); // Move to the next step
            Shiny.setInputValue(`${id}_userdata`, shinyData); // Send user data
        } else {
            Shiny.setInputValue(`${id}_intake`, { intakes }); // Trigger the calculation and send intakes
            onComplete(); // Notify parent to show LoadingScreen
        }
    };

  return (
    <div className="stepper-card">
      <div className="progress-bar">
        <div
          className="progress"
          style={{ width: `${(step / 2) * 100}%` }}
        ></div>
      </div>
      <div className="step-content">
        {step === 1 && (
          <div className="step">
            <p><span className="current-step">1</span>/2 <span className="step-title">Enter your data</span></p>
            <Dropdown initialValue={initShinyData.ethnicity}
                      dropdownOptions={ethinicityOptions}
                      onChange={
                        (value) => handleSliderChange('ethnicity', value)
                      }
            />
            <GenderSwitch initialValue={initShinyData.gender}
                          onChange={
                            (value) => handleSliderChange('gender', value)
                          }
            />
            <NumericSlider
              min={5}
              max={105}
              step={1}
              initialValue={initShinyData.age}
              onChange={
                (value) => handleSliderChange('age', value)
              }
              unit="imperial"
              measure=""
            />
            <NumericSlider
              min={1.00} max={2.20} step={0.01}
              initialValue={initShinyData.height}
              onChange={
                (value) => handleSliderChange('height', value)
              }
              unit="imperial"
              measure="cm"
            />
            <NumericSlider
              min={10} max={210} step={1} initialValue={initShinyData.weight}
              onChange={
                (value) => handleSliderChange('weight', value)
              }
              unit="imperial"
              measure="kg"
            />
            <CategoricalSlider
              options={metabolismOptions}
              initialValue={initShinyData.metabolism}
              onChange={
                (value) => handleSliderChange('metabolism', value)
              }
            />
            <SmokerCheckbox
              initialChecked={initShinyData.smoker}
              onChange={
                (value) => handleSliderChange('smoker', value)
              }
            />
            <CategoricalSlider
              options={unitOptions}
              initialValue={initShinyData.unit}
              onChange={
                (value) => handleSliderChange('unit', value)
              }
            />
            <button onClick={handleNextStep}>Next</button>
          </div>
        )}
        {step === 2 && (
          <div className="step">
            <p onClick={() => setStep(1)}>1/<span className="current-step">2</span><span className="step-title">Enter intake data</span></p>
            <Intake
              intakes={intakes}
              onIntakeChange={handleIntakeChange}
              onAddIntake={handleAddIntake}
              onRemoveIntake={handleRemoveIntake}
              coffeeTypeOptions={coffeeTypeOptions}
              startCalc={handleNextStep}
            />
          </div>
        )}
      </div>
    </div>
  );
}
