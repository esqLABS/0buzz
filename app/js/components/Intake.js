const { useState } = React;
const DropdownCoffeeType = require('./DropdownCoffeeType.js').default;

export default function Intake({ intakes, onIntakeChange, onAddIntake, onRemoveIntake, coffeeTypeOptions, startCalc }) {
    const handleChange = (index, event) => {
        const { name, value, type, checked } = event.target;
        const updatedIntakes = [...intakes];
        if (type === 'checkbox') {
            updatedIntakes[index][name] = checked;
        } else {
            updatedIntakes[index][name] = value;
        }
        onIntakeChange(updatedIntakes);
    };

    const handleCoffeeTypeChange = (index, value) => {
      console.log(value);
      console.log(index);
      console.log(intakes);
      const updatedIntakes = [...intakes];
      updatedIntakes[index].type = value;
      onIntakeChange(updatedIntakes);
    }

    return (
        <div className="intake-container">
            {intakes.map((intake, index) => (
                <div className="intake-record" key={index}>
                    <input
                        className="intake-record-selected"
                        type="checkbox"
                        name="selected"
                        checked={intake.selected}
                        onChange={(event) => handleChange(index, event)}
                    />
                    <DropdownCoffeeType
                      initialValue={intake.type}
                      dropdownOptions={coffeeTypeOptions}
                      onChange={
                        (value) => handleCoffeeTypeChange(index, value)
                      }
                      className="intake-record-dropdown"
                    />
                    <input
                        type="time"
                        name="time"
                        value={intake.time}
                        onChange={(event) => handleChange(index, event)}
                        className="intake-record-time"
                    />
                    <span className="intake-record-remove" onClick={() => onRemoveIntake(index)}>
                      <img src="static/icons/delete.png"/>
                    </span>
                </div>
            ))}
            <div class="intake-button-group">
              <button className="add-intake-btn" onClick={onAddIntake}>Add Intake</button>
              <button onClick={startCalc}>Calculate</button>
            </div>
        </div>
    );
}

