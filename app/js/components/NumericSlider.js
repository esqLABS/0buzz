const { useState } = React;
const { FiInfo } = require('react-icons/fi');

export default function NumericSlider({ min, max, initialValue, step, onChange, unit, measure }) {
    const [value, setValue] = useState(initialValue);

    const handleSliderChange = (event) => {
        const newValue = Number(event.target.value);
        setValue(newValue);
        if (onChange) {
            onChange(newValue);
        }
    };

    // Function to calculate decimal places based on the step value
    const getDecimalPlaces = (num) => {
        const parts = num.toString().split('.');
        return parts.length > 1 ? parts[1].length : 0;
    };

    const decimalPlaces = getDecimalPlaces(step);

    return (
        <div className="numeric-slider">
            <input
                type="range"
                min={min}
                max={max}
                value={value}
                step={step}
                onChange={handleSliderChange}
                className="slider"
            />
            <div className="slider-value">{value.toFixed(decimalPlaces)}<sub>{measure}</sub></div>
        </div>
    );
}
