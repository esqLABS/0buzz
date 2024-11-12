const { useState } = React;

export default function DropdownCoffeeType({ initialValue, dropdownOptions, onChange, className }) {
    const [isOpen, setIsOpen] = useState(false);
    const [selectedOption, setSelectedOption] = useState(initialValue);

    const toggleDropdown = () => setIsOpen((prev) => !prev);

    const handleCoffeeSelect = (option, index) => {
        setSelectedOption(
          {
            [option]: dropdownOptions[option]
          }
        );
        setIsOpen(false);
        if (onChange) {
            onChange(
              {
                [option]: dropdownOptions[option]
              }
            );
        }
    };

    return (
        <div className={`${className} dropdown-container`}>
            <div className="dropdown-header" onClick={toggleDropdown}>
                {Object.keys(selectedOption)[0] || 'Select an option'}
                <span className={`arrow ${isOpen ? 'open' : ''}`}></span>
            </div>
            {isOpen && (
                <ul className="dropdown-list">
                    {Object.keys(dropdownOptions).map((option, index) => (
                        <li key={index} className="list-item" onClick={() => handleCoffeeSelect(option, index)}>
                            <div>{option}</div>
                            <div className="list-item-coffee-type-description">
                              <img src="static/icons/water.png"/> {dropdownOptions[option].water}
                              <img src="static/icons/coffeebeans.png"/> {dropdownOptions[option].caffein}
                            </div>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
}
