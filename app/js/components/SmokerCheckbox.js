const { useState } = React;
const { FiInfo } = require('react-icons/fi');


export default function SmokerCheckbox({ initialChecked, onChange }) {
    const [isChecked, setIsChecked] = useState(initialChecked);
    const [showTooltip, setShowTooltip] = useState(false);

    const handleCheckboxChange = (event) => {
        const checked = event.target.checked;
        setIsChecked(checked);
        if (onChange) {
            onChange(checked);
        }
    };

    return (
        <div className="smoker-checkbox">
            <label className="custom-checkbox">
                <input
                    type="checkbox"
                    checked={isChecked}
                    onChange={handleCheckboxChange}
                />
                <span className="checkbox-indicator"></span>
                Smoker
            </label>
            <span
                className="icon-wrapper"
                onMouseEnter={() => setShowTooltip(true)}
                onMouseLeave={() => setShowTooltip(false)}
            >
              <FiInfo className="icon" />
                {showTooltip && (
                    <div className="tooltip">Select if you smoke.</div>
                )}
          </span>
      </div>
    );
}
