const { useState } = React;
const DropdownCoffeeType = require('./DropdownCoffeeType.js').default;

export default function Intake({ intakes, onIntakeChange, onAddIntake, onRemoveIntake, coffeeTypeOptions, startCalc, showInitIntake, showEditIntake }) {

  console.log("Intake window", intakes)

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
      const updatedIntakes = [...intakes];
      updatedIntakes[index].type = value;
      onIntakeChange(updatedIntakes);
    }

    return (
        <div className="intake-container">
            {intakes.map((intake, index) => (
                <div className="intake-record" key={index}>
                    <label className="custom-checkbox">
                      <input
                          className="intake-record-selected"
                          type="checkbox"
                          name="selected"
                          checked={intake.selected}
                          onChange={(event) => handleChange(index, event)}
                      />
                      <span className="checkbox-indicator"></span>
                    </label>
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
            {showInitIntake &&
              (
                <div class="intake-button-group">
                  <button className="add-intake-btn" onClick={onAddIntake}>Add Intake</button>
                  <button onClick={startCalc}>Submit</button>
                </div>
              )
            }

            {showEditIntake &&
              (
                <div className="intake-edit-container">
                  <hr/>
                  <div class="intake-button-group-edit">
                    <button className="edit-add-intake-btn" onClick={onAddIntake}>Add Intake</button>
                    <p>How much caffeine <br/> have you had today?</p>
                  </div>
                </div>
              )
            }

        </div>
    );
}

