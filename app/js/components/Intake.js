const { useState } = React;

export default function Intake({ intakes, onIntakeChange, onAddIntake }) {
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

    return (
        <div className="intake-container">
            <h2>Intake Records</h2>
            {intakes.map((intake, index) => (
                <div className="intake-record" key={index}>
                    <input
                        type="text"
                        name="type"
                        placeholder="Type"
                        value={intake.type}
                        onChange={(event) => handleChange(index, event)}
                    />
                    <input
                        type="time"
                        name="time"
                        value={intake.time}
                        onChange={(event) => handleChange(index, event)}
                    />
                    <label>
                        <input
                            type="checkbox"
                            name="selected"
                            checked={intake.selected}
                            onChange={(event) => handleChange(index, event)}
                        />
                        Selected
                    </label>
                </div>
            ))}
            <button onClick={onAddIntake}>Add More Intake Record</button>
        </div>
    );
}
