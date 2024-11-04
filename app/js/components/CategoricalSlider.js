const { useState } = React;
const { SlUser, SlUserFemale } = require('react-icons/sl');

export default function CategoricalSlider({ options, initialValue, onChange }) {
    const [selectedOption, setSelectedOption] = useState(initialValue);

    const handleOptionChange = (event) => {
        const newValue = event.target.value;
        setSelectedOption(newValue);
        if (onChange) {
            onChange(newValue);
        }
    };

    return (
        <div className="categorical-slider">
            {options.map((option) => (
                <label
                    key={option}
                    className={`slider-option ${selectedOption === option ? 'active' : ''}`}
                >
                    <input
                        type="radio"
                        value={option}
                        checked={selectedOption === option}
                        onChange={handleOptionChange}
                        className="slider-input"
                    />
                    {option}
                </label>
            ))}
        </div>
    );
}
