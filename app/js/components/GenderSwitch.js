const { useState } = React;
const { SlUser, SlUserFemale } = require('react-icons/sl');

export default function GenderSwitch({ initialValue, onChange }) {
    const [selectedGender, setSelectedGender] = useState(initialValue);

    const handleToggle = (gender) => {
        setSelectedGender(gender);
        if (onChange) {
            onChange(gender);
        }
    };

    return (
        <div className="gender-switch">
            <div
                className={`switch-option ${selectedGender === 'male' ? 'active' : ''}`}
                onClick={() => handleToggle('male')}
            >
                <SlUser/>
            </div>
            <div
                className={`switch-option ${selectedGender === 'female' ? 'active' : ''}`}
                onClick={() => handleToggle('female')}
            >
                <SlUserFemale/>
            </div>
        </div>
    );
}
