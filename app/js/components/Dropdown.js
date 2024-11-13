const { useState } = React;
const { SlUser, SlUserFemale } = require('react-icons/sl');

export default function Dropdown({ initialValue, dropdownOptions, onChange }) {
    const [isOpen, setIsOpen] = useState(false);
    const [selectedOption, setSelectedOption] = useState(initialValue);

    const toggleDropdown = () => setIsOpen((prev) => !prev);

    const handleSelect = (option) => {
        setSelectedOption(option);
        setIsOpen(false);
        if (onChange) {
            onChange(option);
        }
    };

    return (
        <div className="dropdown-container">
            <div className="dropdown-header" onClick={toggleDropdown}>
                {selectedOption || 'Select an option'}
                <span className={`arrow ${isOpen ? 'open' : ''}`}>↓</span>
            </div>
            {isOpen && (
                <ul className="dropdown-list">
                    {dropdownOptions.map((option, index) => (
                        <li key={index} className="list-item" onClick={() => handleSelect(option)}>
                            {option}
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
}
